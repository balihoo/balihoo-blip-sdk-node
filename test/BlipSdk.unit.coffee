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

    context 'when the version number is specified and invalid', ->
      it 'throws an UnknownApiVersionError', ->
        try
          version = 'ohno!'
          sdk = new BlipSdk apiKey: 'key', secretKey: 'asdf', version: version
          assert.fail 'Expected UnknownApiVersionError'
        catch err
          assert err instanceof error.UnknownApiVersionError
          assert.strictEqual err.version, version