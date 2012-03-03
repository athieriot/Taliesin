fs = require 'fs' 
props = require 'props'

default_file_name = '.taliesin.conf'
default_file_path = process.env[if process.platform is 'win32' then 'USERPROFILE' else 'HOME'] + '/' + default_file_name

configuration = (callback, path = default_file_path, create = true) ->
   fs.readFile path, (err, data) ->
      if (err)
         if(create)
            fs.open path, 'a', (err, fd) ->
               fs.close fd
         callback {}
      else
         callback(props data)

module.exports = {
   configuration: configuration
}
