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
   .action((id) ->
      logger = initLogger program.verbose
      
      logger.verbose 'Enter build command'
      teamcity.build id, program.branch, logger
   )

program.parse process.argv
