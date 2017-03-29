gulp    = require 'gulp'
uglify  = require 'gulp-uglify'
riot    = require 'gulp-riot'
coffee  = require 'gulp-coffee'
jade    = require 'gulp-jade'
plumber = require 'gulp-plumber'

# Jade
gulp.task 'jade', ->
	gulp.src 'src/views/jade/*.jade'
		.pipe plumber()
		.pipe jade()
		.pipe gulp.dest 'src/views/html'

# CoffeeScript
gulp.task 'coffee', ->
	gulp.src 'src/bin/coffee/*.coffee'
		.pipe plumber()
		.pipe coffee()
		.pipe uglify()
		.pipe gulp.dest 'src/bin/js'

# Riot
gulp.task 'riot', ->
	gulp.src 'src/scripts/components/tag/*.tag'
		.pipe plumber()
		.pipe riot
			compact  : true
			type     : 'coffeescript'
			template : 'jade'
		.pipe gulp.dest 'src/scripts/components/js'

# Default
gulp.task 'default', ['jade', 'coffee', 'riot']

# Watch
gulp.task 'watch', ->
	gulp.watch [
		'src/views/jade/*.jade'
		'src/bin/coffee/*.coffee'
		'src/scripts/components/tag/*.tag'
	], ['jade', 'coffee', 'riot']