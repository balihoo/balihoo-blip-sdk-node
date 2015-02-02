exports.MissingCredentialsError = class MissingCredentialsError extends Error
  constructor: ->
    @message = 'Credentials appear to be missing.  Please supply both apiKey and secretKey.'

exports.BadResponseError = class BadResponseError extends Error
  constructor: (@operationId, @responseCode, @body) ->
    @message = "Bad response #{@responseCode} for operation #{@operationId}.  Error code: #{@body?.code}, Message: #{@body?.message}"

exports.RequiredParameterMissingError = class RequiredParameterMissingError extends Error
  constructor: (@operationId, @paramName) ->
    @message = "Operation #{@operationId} failed due to missing required parameter '#{@paramName}'."