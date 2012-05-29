archetype = require '../lib/archetype'
fs = require 'fs'
mkdirp = require 'mkdirp'

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

    it 'should filter multiple variables', ->
      archetype.generate 'test/archetypes/multiple_vars/', 'test/sandbox/multiple_vars/', projectName: 'unknown', version: '9.0.1'
      fs.readFileSync('test/sandbox/multiple_vars/package.json', 'utf8').should.equal \
        """
        {
            "name": "unknown",
            "version": "9.0.1"
        }

        """

    it 'should work with existing directories', ->
      mkdirp.sync 'test/sandbox/no_replace/'
      archetype.generate 'test/archetypes/no_replace', 'test/sandbox/no_replace'
      fs.readFileSync('test/sandbox/no_replace/myfile.arbitrary', 'utf8').should.equal "arbitrary file is arbitrary\n"

    it 'should overwrite existing files', ->
      mkdirp.sync 'test/sandbox/no_replace/'
      fs.writeFileSync 'test/sandbox/no_replace/myfile.arbitrary', 'TROLOLOLO', 'utf8'
      archetype.generate 'test/archetypes/no_replace', 'test/sandbox/no_replace'
      fs.readFileSync('test/sandbox/no_replace/myfile.arbitrary', 'utf8').should.equal "arbitrary file is arbitrary\n"

    it 'should not overwrite files it does not normally create', ->
      mkdirp.sync 'test/sandbox/no_replace/'
      fs.writeFileSync 'test/sandbox/no_replace/trololo.arbitrary', 'TROLOLOLO\n', 'utf8'
      archetype.generate 'test/archetypes/no_replace', 'test/sandbox/no_replace'
      fs.readFileSync('test/sandbox/no_replace/myfile.arbitrary', 'utf8').should.equal "arbitrary file is arbitrary\n"
      fs.readFileSync('test/sandbox/no_replace/trololo.arbitrary', 'utf8').should.equal "TROLOLOLO\n"
