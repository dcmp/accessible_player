###
Cakefile for DCMP accessible_player
###

{spawn, exec} = require 'child_process'

task 'watch', 'Watch source files and rebuild CSS / JS', (options) ->
	execute = (cmd, args) ->
		proc = spawn cmd, args
		proc.stdout.on 'data', (buffer) -> console.log buffer.toString()
		proc.stderr.on 'data', (buffer) -> console.log buffer.toString()
		proc.on        'exit', (status) -> process.exit(1) if status != 0

	execute 'coffee', ['-w', '-c', '-o', 'lib', 'src']
	execute 'sass', ['--scss', '--watch', 'sass:lib']
