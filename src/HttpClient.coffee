'use strict'
Promise = require 'bluebird'
http = require 'http'
https = require 'https'
clone = require 'clone'

class HttpClient
  constructor: (options) ->
    @options =
      host: options.host
      port: options.port
      headers: {}

    @options.headers['Content-Type'] = 'application/json'
    @options.headers['Authorization'] =
      'Basic ' + new Buffer(options.apiKey + ':' + options.secretKey).toString('base64')

    if options.ssl
      @agent = new https.Agent()
      @agent.rejectUnauthorized = false
    else
      @agent = new http.Agent()

    @agent.maxSockets = options.concurrency or 10

  request: Promise.method (method, path, data) ->
    httpOptions = clone @options
    httpOptions.method = method
    httpOptions.path = path
    httpOptions.agent = @agent

    if data
      data = JSON.stringify data
      httpOptions.headers['Content-Length'] = data.length

    new Promise (resolve, reject) =>
      protocol = if @options.ssl then https else http
      request = protocol.request httpOptions, (response) ->
        response.on 'data', (chunk) ->
          response.body = JSON.parse(chunk.toString())

        response.on 'end', () ->
          resolve response

        response.on 'error', (err) ->
          reject err

      request.write data  if data
      request.on 'error', (err) ->
        reject err
      request.end()

  get: (path) ->
    @request 'GET', path, null

  put: (path, data) ->
    @request 'PUT', path, data

  post: (path, data) ->
    @request 'POST', path, data

  patch: (path, data) ->
    @request 'PATCH', path, data

  delete: (path) ->
    @request 'DELETE', path, null

module.exports = HttpClient