#!/usr/bin/env coffee

#
# Tool designed to ease dialog with your Software Factory
#

program = require 'commander'
winston = require 'winston'
teamcity = require './lib/teamcity'

initLogger = (verbose) ->
   new winston.Logger({
      transports: [
         new (winston.transports.Console) {
            level: if verbose then "verbose" else "info"
         }
      ]
   }).cli()

program
   .version('0.0.1')
   .option('-b, --branch [master]', 'branch to work with')
   .option('-v, --verbose', 'display debug informations')

program
   .command('build [id]')
   .description('launch builds on your Continuous Integration server')
   .action (id) ->
      logger = initLogger program.verbose
      branch = program.branch

      logger.verbose "Build requested for #{id}" + if branch? then " on branch #{branch}" else ''

      teamcity.build id, program.branch, (res) ->
         logger.info "Build #{id} successfuly launched" + if branch? then " on branch #{branch}" else ''
      , (e) ->
         logger.error "An error append when requesting build #{id} : #{e.message}"
         process.exit 1

program.parse process.argv
