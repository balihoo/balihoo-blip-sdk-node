fs = require 'fs'
swagger2 = require 'swagger2-utils'
mustache = require 'mustache'
argv = require 'yargs'
.usage 'Usage: $0 --version=<version>'
.demand ['version']
.argv

template = fs.readFileSync "#{__dirname}/apiDocs.mustache", 'utf-8'
api = require "../apis/blip-#{argv.version}.json"

operations = swagger2.createOperationsList api

getType = (parameter) ->
  return parameter.schema.type if parameter.schema?.type?
    
  if parameter.oneOf?
    return [schema.type for schema in parameter.oneOf when schema.type?].join '|'

for operation in operations
  for parameter in operation.parameters
    parameter.type ?= getType parameter
      
    if parameter.in is 'body' and parameter.schema?.properties?
      parameter.hasProperties = true
      parameter.propList = swagger2.objectToCollection parameter.schema.properties, 'propertyName'
      for prop in parameter.propList
        prop.type ?= getType prop
        prop.description ?= parameter['x-property-descriptions']?[prop.propertyName]

result = mustache.render template, operations: operations
console.log result