"""
archetype

It's tiny!
"""

fs = require 'fs'
path = require 'path'
mkdirp = require 'mkdirp'

exports.generate = (path, dest, vars) ->
  """
  Generates a new archetype.

  @param path The path to the archetype.
  @param dest The destination to write the generated archetype to.
  @param vars The variables to replace as an object.
  """
  mkdirp.sync dest
  copyAndFilter path, dest

copyAndFilter = (src, dest) ->
  if fs.statSync(src).isDirectory()
    # Filter a directory recursively
    mkdirp.sync dest

    files = fs.readdirSync src
    for file in files
      newName = replaceStr path.basename(file), vars
      copyAndFilter path.join(src, file), path.join(dest, newName)

  else
    # Filter a file
    fileStr = fs.readFileSync src, 'utf8'
    fs.writeFileSync dest, replaceStr(fileStr, vars), 'utf8' # Save

replaceStr = (str, vars) ->
  for var of vars
    fileStr.replace new RegExp('\\$\{' + var.replace('/', '\\/') + '\\}', 'g'), vars[var]
