http = require 'http'
url = require 'url'
commons = require './commons'

hostname = 'teamcity.vidal.net'
username = 'athieriot'
password = 'bA75sT57gA'

teamcity_url = url.parse "http://#{hostname}/httpAuth/action.html"
options = 
   headers:
      Authorization: "Basic #{new Buffer("#{username}:#{password}").toString("base64")}"
      Accept: 'application/json'

add_2_queue = (id, branch) ->
   settings = 
      host: teamcity_url.hostname
      port: teamcity_url.port || 80
      path: teamcity_url.pathname
      headers: options.headers || {}
      method: options.method || 'GET'

   settings.path += "?add2Queue=#{id}"
   if branch? then settings.path += "&env.name=BRANCH&env.value=#{branch}"
   settings

build = (id, branch, logger) ->
   if id?
      logger.verbose "Build requested for #{id}" + if branch? then " on branch #{branch}" else ''
      teamcity_settings = add_2_queue id, branch

      http.get teamcity_settings, (res) ->
         logger.info "Build #{id} successfuly launched" + if branch? then " on branch #{branch}" else ''
      .on 'error', (e) ->
         logger.error "An error append when requesting build #{id} : #{e.message}"
         process.exit 2
   else
      logger.error "No id provided"
      process.exit 1

deploy = (id, branch, logger) ->
   logger.info "Not supported yet"
   process.exit 1

module.exports = {
   build: build,
   deploy: deploy,
   test: {
      add_2_queue
   }
}
