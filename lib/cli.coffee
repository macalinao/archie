commands = require './commands'

module.exports = ->
  cmd = process.argv[2]

  if not cmd
    cmd = "help"

  func = commands[cmd]

  if not func
    console.log \
      """
      Unknown command '#{cmd}'.
      Run 'archie help' for a list of available commands.
      """
    process.exit 1

  func()
