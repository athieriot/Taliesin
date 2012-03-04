http = require 'http'
url = require 'url'
commons = require './commons'

compute_settings = (id, branch, service_conf, success) ->
   teamcity_url = url.parse "http://#{service_conf.hostname}/httpAuth/action.html"
   options = 
      headers:
         Authorization: "Basic #{new Buffer("#{service_conf.username}:#{service_conf.password}").toString("base64")}"
         Accept: 'application/json'

   settings = 
      host: teamcity_url.hostname
      port: teamcity_url.port || 80
      path: teamcity_url.pathname
      headers: options.headers || {}
      method: options.method || 'GET'

   settings.path += "?add2Queue=#{id}"
   if branch? then settings.path += "&env.name=BRANCH&env.value=#{branch}"

   success settings

add_2_queue = (id, branch, conf, success, error) ->
   commons.logger.verbose 'Your Teamcity configuration is : ' + JSON.stringify conf

   if commons.valid_properties conf, 'hostname', 'username', 'password'
      compute_settings id, branch, conf, success
   else
      error 'You need to configure your Teamcity credentials'

build = (id, branch, success, error) ->
   if id?
      commons.configuration (conf) ->
         add_2_queue id, branch, conf, (teamcity_settings) ->
            http.get(teamcity_settings, success).on('error', error)
         , (message) ->
            error {message: message}
   else
      error {message: 'No Id provided'}

deploy = (id, branch, success, error) ->
   error {message: 'Not supported yet'}

module.exports = {
   build: build,
   deploy: deploy,
   test: {
      compute_settings: compute_settings,
      add_2_queue: add_2_queue
   }
}
