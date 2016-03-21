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
- endpoint (string):  The fully qualified URL of BLIP (e.g. http[s]://somehost[:port]/some/path)
- concurrency (number):  The number of concurrent connections to use.  Default is 10, max is 20.
- version (string):  The API version to use.  Default value is the latest version.

## API

### ping()
Returns an indication of service availability

Parameters: none

### getSources()
Returns a list of sources

Parameters:
- brandKey (string):  The brand key (required)

### createSource()
Create a source

Parameters:
- brandKey (string):  The brand key (required)
- body (object)
 - source (string): Create a source
 - type (string): Create a source
 - description (string): Create a source

### getProjections()
Returns a list of projections

Parameters:
- brandKey (string):  The brand key (required)

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

### patchLocations()
Applies the provided patch to each location in the list

Parameters:
- brandKey (string):  The brand key (required)
- source (string):  The source of the location data 
- body (object)
 - patch (array): request body
 - locationKeys (array): request body

### getLocationList()
Returns a list of locations

Parameters:
- brandKey (string):  The brand key (required)
- body (object)
 - query (object): location query
 - view (object): location query

### getLocationCount()
Returns a count of locations

Parameters:
- brandKey (string):  The brand key (required)
- body (object)
 - query (object): location query

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
- source (string):  The source of the location data 
- document (object):  location data (required)

### deleteLocation()
Deletes a location

Parameters:
- brandKey (string):  The brand key (required)
- locationKey (string):  The location key (required)
- source (string):  The source of the location data 

### patchLocation()
Updates a location at the specified event level

Parameters:
- brandKey (string):  The brand key (required)
- locationKey (string):  The location key (required)
- eventId (string):  The event ID to be used as the basis for patch calculation (required)
- source (string):  The source of the location data 
- document (object):  location data (required)

### getLocationById()
Returns a location

Parameters:
- locationId (string):  The location ID (required)
- projection (string):  The data projection to return.  Default is universal. 
- includeRefs (string):  Set to true to include referenced data. 

### patchLocationSigned()
Applies the provided patch to the prescribed location

Parameters:
- locationId (string):  The location ID (required)
- patch (string):  The JIFF patch to be applied (required)
- source (string):  The source of the location data 
- redirect (string):  The URL to which the user should be redirected on success 
- sig (string):  The URL signature (required)

### getLocationIntersect()
Returns the common data between all location projections

Parameters:
- body (object)
 - locationIds (array): location IDs
 - defaultValue (string): location IDs

### getEvents()
Returns a list of events

Parameters:
- brandKey (string):  The brand key (required)
- locationKey (string):  The location key (required)
- source (string):  Filter events to only those from this source 

### createApiKey()
Creates an API key for the specified brands

Parameters:
- body (object)
 - canManageBrands (boolean): Indicates whether the apiKey can create brands and sources
 - brands (array): An array of objects of the following format: { "brandKey": "<brandKey>", "source": "<source>" }
 - notes (string): Additional notes about the intended use of the key.

### deleteApiKey()
Revokes an API key

Parameters:
- apiKey (string):  Revokes an API key (required)

### authorizeUpload()
Returns a signed upload request

Parameters:
- brandKey (string):  The brand key (required)
- fileMD5 (string):  The MD5 hex hash of the file to upload (required)

### bulkLoad()
Bulk load locations from a file

Parameters:
- brandKey (string):  The brand key (required)
- source (string):  The source of the location data 
- s3Path (string):  The full S3 URL for the gzipped JSON file (required)
- implicitDelete (boolean):  Whether locations missing from the file should be deleted (required)
- expectedRecordCount (integer):  The number of location records in the file. (required)
- successEmail (string):  The email address to email upon success. Can be a comma-delimited list. 
- failEmail (string):  The email address to email upon failure. Can be a comma-delimited list. 
- successCallback (string):  The URL to be requested upon success. 
- failCallback (string):  The URL to be requested upon failure. 

### getDocs()
Returns the API documentation

Parameters: none


