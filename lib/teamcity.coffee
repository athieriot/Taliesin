build = (id, branch, logger) ->
   if id?
      logger.verbose "Build requested for #{id} on branch #{branch}"
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
