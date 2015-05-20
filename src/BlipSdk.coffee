fs = require 'fs'
swagger2 = require 'swagger2-utils'
pkg = require '../package.json'
error = require './error'
Requester = require './Requester'
MissingCredentialsError = error.MissingCredentialsError
UnknownApiVersionError = error.UnknownApiVersionError
MAX_CONCURRENCY = 20
DEFAULT_CONCURRENCY = 10
LATEST_VERSION = "1.0.17"

getOperationsForVersion = (version) ->
  fileName = "blip-#{version}.json"
  if fs.existsSync "#{__dirname}/../apis/#{fileName}"
    api = require "../apis/#{fileName}"
    swagger2.createOperationsList api
  else
    throw new UnknownApiVersionError version
    
module.exports =
  class BlipSdk
    concurrency = undefined
    
    constructor: (options) ->
      if not options?.apiKey? or not options?.secretKey?
        throw new error.MissingCredentialsError()
        
      version = options?.version or LATEST_VERSION
      endpoint = options.endpoint or 'https://blip.balihoo-cloud.com'
      concurrency = options.concurrency or DEFAULT_CONCURRENCY
      if concurrency > MAX_CONCURRENCY then concurrency = MAX_CONCURRENCY

      requester = new Requester
        endpoint: endpoint
        concurrency: concurrency
        apiKey: options.apiKey
        secretKey: options.secretKey
      
      operations = getOperationsForVersion version
      operations.forEach (operation) =>
        @[operation.operationId] = (params) ->
          requester.request operation, params
          
    getConcurrency: ->
      concurrency