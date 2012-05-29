module.exports = ->
  argv = require('optimist')
    .usage('Usage: archie gen -a [archetype] -n [name] --arg1 ...')

    .alias('a', 'archetype')
    .describe('a', 'The name (or path, with -p) of the archetype.')

    .alias('n', 'name')
    .describe('n', 'The name of the project.')

    .boolean('p')
    .alias('p', 'path')
    .describe('p', 'The path to the archetype.')

    .demand(['a', 'n'])
    .argv

  archetype = argv.a
  project = argv.n
  path = argv.p


