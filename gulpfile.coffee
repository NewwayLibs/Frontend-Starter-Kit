###
Base imports and vars
###
glob = require 'glob'
gulp = require 'gulp'
util = require 'gulp-util'
consolidate = require "gulp-consolidate"
autoprefixer = require "gulp-autoprefixer"
sass = require "gulp-sass"
coffee = require "gulp-coffee"
inlineCss = require "gulp-inline-css"
extReplace = require 'gulp-ext-replace'
prettify = require 'gulp-html-prettify'
minifyHTML = require 'gulp-minify-html'
compass = require 'gulp-compass'
del = require 'del'
server = require('tiny-lr')()
refresh = require 'gulp-livereload'

log = util.log
colors = util.colors
SERVER_PORT = 8000


log ''
log colors.gray "-----------------------------------"
log "Building project"
log colors.gray "-----------------------------------"
log ''


gulp.task 'sass', ->
  gulp.src ['src/sass/*.sass', '!src/sass/_*']
  #.pipe sass
  #  errLogToConsole: true
  #  sourceComments: 'normal'
  .pipe compass
  #project: '',
    css        : 'build/css/'
    sass       : 'src/sass/'
    image      : 'src/img/'
    require    : ['bootstrap-sass', 'sass-globbing']
    comments   : false
    style      : 'expanded'
    bundle_exec: true
  .on 'error', util.log
  .pipe autoprefixer 'last 2 version', 'safari 5', 'ie 8', 'ie 9', 'opera 12.1', 'ios 6', 'android 4'
  .pipe gulp.dest 'build/css'
  .pipe refresh(server)

gulp.task 'html', ->
  gulp.src 'src/jade/*.jade'
  .pipe consolidate 'jade'
  .pipe extReplace '.html'
  .pipe prettify
    indent_char: ' '
    indent_size: 2
  .pipe gulp.dest 'build'
  .pipe refresh(server)


gulp.task 'coffee', ->
  gulp.src 'src/coffee/**/*'
  .pipe coffee()
  .pipe gulp.dest 'build/js'
  .pipe refresh(server)

# Cleanup build directory
gulp.task 'clean', (cb)->
  del ['build'], cb


#Copy all static assets
gulp.task 'copy', ->
  log ''
  log colors.gray "-----------------------------------"
  log "Build Status: " + colors.yellow("Copying Files")
  log colors.gray "-----------------------------------"
  log ''


  gulp.src 'src/img/**/*'
  .pipe gulp.dest 'build/img'

  gulp.src 'src/js/**/*'
  .pipe gulp.dest 'build/js'

  gulp.src 'src/fonts/**/*'
  .pipe gulp.dest 'build/fonts'

  gulp.src 'src/vendor/**/*'
  .pipe gulp.dest 'build/vendor'


# Live Reload Server for instant file change reload
gulp.task 'livereload', ->
  log ''
  log colors.gray "-----------------------------------"
  log "Build Status: " + colors.yellow("Starting Live Reload Server")
  log colors.gray "-----------------------------------"
  log ''

  server.listen 35729, (err)->
    if (err)
      console.log(err)


#Servers for web and api
gulp.task 'servers', (callback)->
  log = util.log
  colors = util.colors;

  log ''
  log colors.gray "-----------------------------------";
  log "Build Status: " + colors.yellow("Starting Servers")
  log colors.gray "-----------------------------------"
  log ''

  apiServer = require './api-stub/routes.js'
  apiServer log, colors

  webServer = require './api-stub/server.js'
  webServer({
    port  : SERVER_PORT
    log   : log
    colors: colors
  })


#gulp watch
gulp.task 'watch', ->
  log ''
  log colors.gray "-----------------------------------"
  log "Build Status: " + colors.yellow("Watching for changes")
  log colors.gray "-----------------------------------"
  log ''

  gulp.watch 'src/sass/**/*.sass', ['sass']
  gulp.watch 'src/jade/**/*.jade', ['html']
  gulp.watch 'src/coffee/**/*.coffee', ['coffee']


# Build task
gulp.task 'build', ['html', 'copy', 'sass', 'coffee'], ->
  log ''
  log colors.gray "-----------------------------------"
  log "Build Status: " + colors.green("Compiling Build")
  log colors.gray "-----------------------------------"
  log ''


# The default task (called when you run `gulp`)
gulp.task 'default', ['livereload', 'html', 'copy', 'sass', 'coffee', 'servers', 'watch'], ->
  log ''
  log colors.gray "-----------------------------------"
  log "Build Status: " + colors.green("Completed")
  log colors.gray "-----------------------------------"
  log ''


