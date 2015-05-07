'use strict'
Promise = require 'bluebird'
request = require 'request'
http = require 'http'
error = require './error'
BadResponseError = error.BadResponseError
RequiredParameterMissingError = error.RequiredParameterMissingError

module.exports = class Requester
  constructor: (options) ->
    @endpoint = options.endpoint

    @agent = new http.Agent
      maxSockets: options.concurrency

    request = request.defaults
      timeout: 20000
      pool: false
      jar: true
      auth:
        user: options.apiKey
        pass: options.secretKey

    Promise.promisifyAll request

  request: (operation, params) ->
    expectedCode = Object.keys(operation.responses)[0]
    path = operation.path
    body = {}
    queryString = null

    for paramDefinition in operation.parameters
      paramName = paramDefinition.name
      paramValue = params[paramName]

      if paramDefinition.required and not paramDefinition.default? and not paramValue?
        throw new RequiredParameterMissingError operation.operationId, paramDefinition.name

      if paramValue?
        switch paramDefinition.in
          when 'body'
            body = paramValue
          when 'query'
            if queryString then queryString += '&' else queryString = '?'
            queryString += "#{paramName}=#{paramValue}"
          when 'path'
            # Encode the parameter
            paramValue = encodeURIComponent paramValue
            
            # Replace all occurrences in the path
            path = path.split("{#{paramName}}").join paramValue

    if queryString then path += queryString

    request[operation.method + 'Async'](
      @endpoint + path,
      json: body
      agent: @agent
    )
    .spread (response, body) ->
      if response?.statusCode.toString() is expectedCode
        body
      else
        throw new BadResponseError operation.operationId, response?.statusCode, response?.body
