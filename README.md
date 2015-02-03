[![Build Status](https://travis-ci.org/balihoo/balihoo-node-blip-sdk.svg?branch=master)](https://travis-ci.org/balihoo/balihoo-node-blip-sdk)
# Balihoo Node.JS BLIP SDK
This package makes it easy to write software which interacts with the Balihoo Local Information Platform.

## Installation
```
npm install balihoo-blip-sdk
```

## Usage
```javascript
  var BlipSdk = require('balihoo-blip-sdk');
  
  var parameters = {
    apiKey: '...',
    secretKey: '...'
  };
  
  var blipSdk = new BlipSdk(parameters);
```

## Parameters
The following parameters are required:
- apiKey:  The Balihoo-provided API key
- secretKey:  The Balihoo-provided secret key

The following parameters are optional and generally only useful for testing purposes:
- host (string):  Change the hostname to which the SDK should connect.
- port (number):  Change the port to which the SDK should connect.
- ssl (boolean):  Disable SSL.
- concurrency (number):  The number of concurrent connections to use.  Default is 10, max is 20.
- version (string):  The API version to use.  Default value is the latest version.