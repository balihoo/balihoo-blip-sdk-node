assert = require 'assert'
BlipSdk = require '../lib/BlipSdk'
error = require '../lib/error'

describe 'BlipSdk unit tests', ->
  describe 'constructor', ->
    it 'requires apiKey and secretKey', ->
      try
        new BlipSdk()
        assert.fail 'Expected MissingCredentialsError'
      catch err
        assert err instanceof error.MissingCredentialsError

      try
        new BlipSdk secretKey: 'blerp'
        assert.fail 'Expected MissingCredentialsError'
      catch err
        assert err instanceof error.MissingCredentialsError

      try
        new BlipSdk apiKey: 'blerp'
        assert.fail 'Expected MissingCredentialsError'
      catch err
        assert err instanceof error.MissingCredentialsError

    it 'uses a default host and port', ->
      sdk = new BlipSdk apiKey: 'key', secretKey: 'shhhhh'
      assert.ok sdk.requester.httpClient.options.host
      assert.ok sdk.requester.httpClient.options.port
