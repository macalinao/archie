archetype = require '../lib/archetype'
fs = require 'fs'

describe 'archetype', ->
  describe '#generate()' , ->
    it 'should copy files verbatim without replaces', ->
      archetype.generate 'test/archetypes/no_replace', 'test/sandbox/no_replace'
      fs.readFileSync('test/sandbox/no_replace/myfile.arbitrary', 'utf8').should.equal "arbitrary file is arbitrary\n"

    it 'should filter file names', ->
      archetype.generate 'test/archetypes/file_names', 'test/sandbox/file_names', var1: 'awesome'
      fs.readFileSync('test/sandbox/file_names/awesome.json', 'utf8').should.equal "nothing\n"

    it 'should filter files', ->
      archetype.generate 'test/archetypes/one_var', 'test/sandbox/one_var', asdf: 'cool site'
      fs.readFileSync('test/sandbox/one_var/super.html', 'utf8').should.equal \
        "<html><head><title>cool site</title></head><body>ASDF</body></html>\n"
