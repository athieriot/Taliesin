#!/usr/bin/env coffee

#
# Tool designed to ease dialog with your Software Factory
#

program = require 'commander'
winston = require 'winston'
teamcity = require 'lib/teamcity'

initLogger = (verbose) ->
   new winston.Logger {
      transports: [
         new (winston.transports.Console) {
            level: if verbose then "debug" else "info"
         }
      ]
   }

program
   .version('0.0.1')
   .option('-b, --branch [master]', 'branch to work with')
   .option('-v, --verbose', 'display debug informations')

program
   .command('build [id]')
   .description('launch build on the CI server')
   .action((id) ->
      logger = initLogger(program.verbose)
      teamcity.build(id, program.branch)
      logger.info 'info test'
      logger.debug 'debug test'
   )

program.parse process.argv
