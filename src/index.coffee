child_process = require 'child_process'

module.exports = class DoccoRunner
  brunchPlugin: yes
  type: 'javascript'
  extension: 'js'
  pattern: /src\/.+\.(js|coffee|litcoffee)/
  files: []

  constructor: (@config) ->

  compile: (params, callback) ->
    @files.push(params.path) unless params.path in @files
    callback null, params

  onCompile: (generatedFiles) ->
    execPath = 'node_modules/docco-brunch/node_modules/docco/bin/docco'
    command = "#{execPath} #{@files.join(' ')}"

    child_process.exec command, (error, stdout, stderr) ->
      console.log "exec error: #{error}" if error?

