#!/usr/bin/env coffee

#
# Tool designed to ease dialog with your Software Factory
#

program = require 'commander'
teamcity = require './lib/teamcity'
commons = require './lib/commons'

program
   .version('0.0.1')
   .option('-b, --branch [master]', 'branch to work with')
   .option('-v, --verbose', 'display debug informations')

program
   .command('build [id]')
   .description('launch builds on your Continuous Integration server')
   .action (id) ->
      branch = program.branch
      commons.init_logger program.verbose

      commons.logger.verbose "Build requested for #{id}" + if branch? then " on branch #{branch}" else ''

      teamcity.build id, branch, (res) ->
         commons.logger.info "Build #{id} successfuly launched" + if branch? then " on branch #{branch}" else ''
      , (e) ->
         commons.logger.error "An error append when requesting build #{id} : #{e.message}"
         process.exit 1

program.parse process.argv
