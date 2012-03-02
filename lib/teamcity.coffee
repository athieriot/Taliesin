http = require 'http'
url = require 'url'

hostname = 'teamcity.vidal.net'
username = 'athieriot'
password = 'bA75sT57gA'

teamcity_url = url.parse "http://#{hostname}/httpAuth/action.html"
options = 
   headers:
      Authorization: "Basic #{new Buffer("#{username}:#{password}").toString("base64")}"
      Accept: 'application/json'
settings = 
   host: teamcity_url.hostname
   port: teamcity_url.port || 80
   path: teamcity_url.pathname
   headers: options.headers || {}
   method: options.method || 'GET'

add_2_teamcity_queue = (id, branch, callback, error) ->
   settings.path += "?add2Queue=#{id}"
   settings.path += "&env.name=BRANCH&env.value=#{branch}"

   http.get(settings, callback).on('error', error) 

build = (id, branch, logger) ->
   if id?
      logger.verbose "Build requested for #{id} on branch #{branch}"

      add_2_teamcity_queue id, branch, (res) ->
         logger.info "Build #{id} successfuly launched on branch #{branch}"
      , (e) ->
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
   deploy: deploy
}
