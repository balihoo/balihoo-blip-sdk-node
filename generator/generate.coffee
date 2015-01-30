'use strict'
swagger2 = require 'swagger2-utils'
argv = require 'yargs'
.usage 'Usage: $0 --api=<path to api.json>'
.demand ['api']
.argv

apiDoc = require argv.api

operations = swagger2.createOperationsList apiDoc
console.log operations

