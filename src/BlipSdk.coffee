swagger2 = require 'swagger2-utils'
pkg = require '../package.json'
error = require './error'
Requester = require './Requester'
MissingCredentialsError = error.MissingCredentialsError
api = require '../api.json'
operations = swagger2.createOperationsList api

module.exports =
  class BlipSdk
    constructor: (options) ->
      if not options?.apiKey? or not options?.secretKey?
        throw new error.MissingCredentialsError()

      host = options.host or 'blip.balihoo-cloud.com'
      port = options.port or 443
      ssl = if options.ssl? then options.ssl else true
      concurrency = options.concurrency or 10

      @requester = new Requester
        host: host
        port: port
        ssl: ssl
        concurrency: concurrency
        apiKey: options.apiKey
        secretKey: options.secretKey
        
      operations.forEach (operation) =>
        @[operation.operationId] = (params) =>
          @requester.request operation, params