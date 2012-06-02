"""
Git support for archie.

Uses the command line -- sorry Windows users!
"""
mkdirp = require 'mkdirp'
rimraf = require 'rimraf'
exec = require('child_process').exec
archie = require './../'

module.exports = (archetype, vars) ->
  temp = './~temp'

  checkIfDir = (folder) ->
    try
      return fs.statSync(temp).isDirectory()
    catch error
      return false

  while checkIfDir temp
    temp += 'p'

  exec "git clone #{archetype.url} #{temp}", (error, stdout, stderr) ->
    return console.error "ERROR: Git cloning error: #{error}" if error?
    console.log "Cloned git repostory at #{archetype.url}."

    dest = "./#{vars.name}/"

    archie.generate temp, dest, vars

    # Remove dumb files
    rimraf "#{dest}.git/", (err) ->
    rimraf temp, (err) ->
