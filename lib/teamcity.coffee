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

build = (id, branch, success, error) ->
   if id?
      teamcity_settings = add_2_queue id, branch
      http.get(teamcity_settings, success).on('error', error)
   else
      error {message: 'No Id provided'}

deploy = (id, branch, success, error) ->
   error {message: 'Not supported yet'}

module.exports = {
   build: build,
   deploy: deploy,
   test: {
      add_2_queue
   }
}
