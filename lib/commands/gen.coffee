module.exports = ->
  argv = require('optimist')
    .usage('Usage: archie gen -a [archetype] -n [name] --arg1 ...')

    .alias('a', 'archetype')
    .describe('a', 'Name (or path, with -p) of the archetype.')

    .alias('n', 'name')
    .describe('n', 'Name of the project.')

    .boolean('p')
    .alias('p', 'path')
    .describe('p', 'Path to the archetype.')

    .demand(['a', 'n'])
    .argv

  archetype = argv.a
  project = argv.n
  path = argv.p

  archie = require '../'

  unless path
    archie.generateFromRepo archetype, './#{project}/', argv

  else
    archie.generate archetype, './#{project}/', argv
