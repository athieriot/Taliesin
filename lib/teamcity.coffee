build (id, branch) ->
   console.log "Successful module"
   console.log 'launch build', id
   console.log 'on branch %s', branch || 'master')

module.exportsi = {
   build: build,
   deploy: undefined
}
