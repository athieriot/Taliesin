build = (id, branch, logger) ->
   if id?
      logger.verbose "Build requested for #{id} on branch #{branch}"
   else
      logger.error "No id provided"


deploy = (id, branch, logger) ->
   logger.info "Not supported yet"

module.exports = {
   build: build,
   deploy: deploy
}
