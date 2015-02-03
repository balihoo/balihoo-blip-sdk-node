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

result = mustache.render template, operations: operations
console.log result