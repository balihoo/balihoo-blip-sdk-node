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

## API

### getSources()
Returns a list of configured sources

Parameters: none

### getProjections()
Returns a list of configured projections

Parameters: none

### getBrandKeys()
Returns a list of brand keys to which the user has access

Parameters: none

### getBrand()
Returns the requested brand details

Parameters:
- brandKey (string):  The brand key (required)

### putBrand()
Create or update a brand

Parameters:
- brandKey (string):  The brand key (required)

### getLocationKeys()
Returns a list of location keys

Parameters:
- brandKey (string):  The brand key (required)
- projection (string):  Filter list to only locations that exist in this projection.  Default is universal.

### getLocation()
Returns a location

Parameters:
- brandKey (string):  The brand key (required)
- locationKey (string):  The location key (required)
- projection (string):  The data projection to return.  Default is universal.
- includeRefs (string):  Set to true to include referenced data.

### putLocation()
Creates or updates a location

Parameters:
- brandKey (string):  The brand key (required)
- locationKey (string):  The location key (required)
- source (string):  The source of the location data (required)
- document ():  location data (required)

### getEvents()
Returns a list of events

Parameters:
- brandKey (string):  The brand key (required)
- locationKey (string):  The location key (required)
- source (string):  Filter events to only those from this source

### postApiKey()
Creates an API key for the specified brands

Parameters:
- body ():  brandKeys (required)

### deleteApiKey()
Revokes an API key

Parameters:
- apiKey (string):  Revokes an API key (required)

### getDocs()
Returns the API documentation

Parameters: none
