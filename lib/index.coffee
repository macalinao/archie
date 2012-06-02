"""
archie

It's tiny!
"""

exec = require('child_process').exec
https = require 'https'
fs = require 'fs'
path = require 'path'
mkdirp = require 'mkdirp'
rimraf = require 'rimraf'

exports.generateFromRepo = (arch, dest, vars) ->
  temp = './~temp'
  while fs.statSync(temp).isDirectory()
    temp += 'p'
  mkdirp temp

  arch = arch.toLowerCase()
  contents = ''

  https.get
    host: 'raw.github.com'
    path: '/simplyianm/archie/master/archetypes/#{arch}.json'
  , (res) -> res.on 'data', (d) -> contents += d

  console.log contents

exports.generate = (src, dest, vars) ->
  """
  Generates a new archetype.

  @param src The path to the archetype.
  @param dest The destination to write the generated archetype to.
  @param vars The variables to replace as an object.
  """
  if not vars?
    vars = {}

  mkdirp.sync dest
  copyAndFilter src, dest, vars

exports.cli = require './cli'

copyAndFilter = (src, dest, vars) ->

  filterStr = (str, vars) ->
    for tvar of vars
      str = str.replace new RegExp('\\$\{' + tvar.replace('/', '\\/') + '\\}', 'g'), vars[tvar]
    return str

  if fs.statSync(src).isDirectory()
    # Filter a directory recursively
    mkdirp dest

    files = fs.readdirSync src
    for file in files
      newName = filterStr path.basename(file), vars
      copyAndFilter path.join(src, file), path.join(dest, newName), vars

  else
    # Filter a file
    fileStr = fs.readFileSync src, 'utf8'
    fs.writeFileSync dest, filterStr(fileStr, vars), 'utf8' # Save
