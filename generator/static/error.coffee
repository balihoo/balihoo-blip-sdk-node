exports.MissingCredentialsError = class MissingCredentialsError extends Error
  constructor: ->
    @message = 'Credentials appear to be missing.  Please supply both apiKey and secretKey.'

exports.BadResponseError = class BadResponseError extends Error
  constructor: (operationId, body) ->
    @message = "Bad response for operation #{operationId}.  Code: #{body?.code}, Message: #{body?.message}"