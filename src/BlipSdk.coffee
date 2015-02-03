fs = require 'fs'
swagger2 = require 'swagger2-utils'
pkg = require '../package.json'
error = require './error'
Requester = require './Requester'
MissingCredentialsError = error.MissingCredentialsError
UnknownApiVersionError = error.UnknownApiVersionError
MAX_CONCURRENCY = 20
DEFAULT_CONCURRENCY = 10

getOperationsForVersion = (version) ->
  fileName = "blip-#{version}.json"
  if fs.existsSync "#{__dirname}/../apis/#{fileName}"
    api = require "../apis/#{fileName}"
    swagger2.createOperationsList api
  else
    throw new UnknownApiVersionError version
    
module.exports =
  class BlipSdk
    constructor: (options) ->
      if not options?.apiKey? or not options?.secretKey?
        throw new error.MissingCredentialsError()
        
      version = options?.version or pkg.version
      host = options.host or 'blip.balihoo-cloud.com'
      port = options.port or 443
      ssl = if options.ssl? then options.ssl else true
      concurrency = options.concurrency or DEFAULT_CONCURRENCY
      if concurrency > MAX_CONCURRENCY then concurrency = MAX_CONCURRENCY

      requester = new Requester
        host: host
        port: port
        ssl: ssl
        concurrency: concurrency
        apiKey: options.apiKey
        secretKey: options.secretKey
        
      operations = getOperationsForVersion version
      operations.forEach (operation) =>
        @[operation.operationId] = (params) =>
          requester.request operation, params