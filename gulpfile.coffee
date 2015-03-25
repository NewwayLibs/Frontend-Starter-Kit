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
del = require 'del';

gulp.task 'sass', ->
  gulp.src ['src/sass/*.sass', '!src/sass/_*']
    #.pipe sass
    #  errLogToConsole: true
    #  sourceComments: 'normal'
    .pipe compass
      #project: '',
      css: 'build/css/'
      sass: 'src/sass/'
      image: 'src/img/'
      require: ['bootstrap-sass', 'sass-globbing']
      comments: false
      style: 'expanded'
      bundle_exec: true
    .on 'error', util.log
    .pipe autoprefixer 'last 2 version', 'safari 5', 'ie 8', 'ie 9', 'opera 12.1', 'ios 6', 'android 4'
    .pipe gulp.dest 'build/css'

gulp.task 'html', ->
  gulp.src 'src/jade/*.jade'
    .pipe consolidate 'jade'
    .pipe extReplace '.html'
    .pipe prettify
      indent_char: ' '
      indent_size: 2
    .pipe gulp.dest 'build'

gulp.task 'img', ->
  gulp.src 'src/img/**/*'
    .pipe gulp.dest 'build/img'

gulp.task 'js', ->
  gulp.src 'src/js/**/*'
    .pipe gulp.dest 'build/js'

gulp.task 'fonts', ->
  gulp.src 'src/fonts/**/*'
    .pipe gulp.dest 'build/fonts'

gulp.task 'coffee', ->
  gulp.src 'src/coffee/**/*'
    .pipe coffee()
    .pipe gulp.dest 'build/js'

gulp.task 'cleanup', (cb)->
  del ['build/**'], cb



gulp.task 'default', ['html', 'fonts', 'img', 'sass', 'js', 'coffee']

gulp.task 'watch', ->
  gulp.watch 'src/sass/**/*.sass', ['sass']
  gulp.watch 'src/js/**/*.js', ['js']
  gulp.watch 'src/jade/**/*.jade', ['html']
  gulp.watch 'src/coffee/**/*.coffee', ['coffee']