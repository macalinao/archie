"""
archie

It's tiny!
"""

request = require 'superagent'
fs = require 'fs'
path = require 'path'
mkdirp = require 'mkdirp'

exports.generateFromRepo = (arch, dest, vars) ->
  arch = arch.toLowerCase()
  req = request.get "https://raw.github.com/simplyianm/archie/master/archetypes/#{arch}.json"
  req.end (res) ->
    text = res.text
    if text is null
      console.error "ERROR: Attempted to generate from invalid archetype `#{arch}`!"
      return

    archetype = null
    try
      archetype = JSON.parse res.text
    catch error
      console.error "ERROR: Invalid JSON archetype description encountered: `#{arch}`\n" + error
      return

    type = archetype.type
    unless type?
      console.error "ERROR: Invalid JSON archetype description `#{arch}` due to a lack of type!"
      return

    defaults = archetype.defaults
    if defaults?
      # Fill 'er up!
      for own name, val of defaults
        vars[name] = val unless vars[name]?

    loaderPath = './types/' + archetype.type
    require(loaderPath) archetype, vars

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
