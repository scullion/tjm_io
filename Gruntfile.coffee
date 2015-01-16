module.exports = (grunt) ->
    grunt.initConfig
        pkg: grunt.file.readJSON('package.json')
        less:
            dev:
                paths: ['less/']
                src: ['less/tjm_io.less']
                dest: 'site/static/css/tjm_io.css'
            dist:
                paths: ['less/']
                src: ['less/tjm_io.less']
                dest: 'site/static/css/tjm_io.min.css'
                options:
                    plugins: [
                        new (require 'less-plugin-autoprefix') browsers: ['> 0.1%']
                        new (require 'less-plugin-clean-css') {}
                    ]
        coffee:
            options:
                join: true
                sourceMap: true
                sourceRoot: '/coffee/'
            build:
                src: 'coffee/tjm_io.coffee'
                dest: 'site/static/js/tjm_io.js'
        uglify:
            options:
                sourceMap: true
                sourceMapIn: 'site/static/js/tjm_io.js.map'
            dist:
                src: 'site/static/js/tjm_io.js'
                dest: 'site/static/js/tjm_io.min.js'
        copy:
            coffee:
                src: 'coffee/*'
                dest: 'site/static/'
        responsive_images:
            process:
                options:
                    engine: 'gm'
                    separator: '_'
                    newFilesOnly: false
                    sizes: [
                        { rename: false, width: '100%', height: '100%' }
                        { name: '64x64', width: 64, height: 64, aspectRatio: false }
                        { name: '128x128', width: 128, height: 128, aspectRatio: false }
                        { name: '300', width: 300, aspectRatio: true }
                    ]
                files: [
                    expand: true
                    cwd: 'img'
                    src: '**.{png,jpg,jpeg,gif}'
                    dest: 'site/static/img'
                ]
        watch:
            options:
                atBegin: true
                livereload: true
            less:
                files: ['less/*.less']
                tasks: 'less:dev'
            coffee:
                files: ['coffee/*.coffee']
                tasks: ['coffee', 'copy:coffee']
            images:
                files: ['img/**']
                tasks: 'responsive_images'
            hugo:
                files: ['site/**']
                tasks: 'hugo:dev'
            all:
                files: ['Gruntfile.coffee']
                tasks: 'dev'
        connect:
            tjm_io:
                options:
                    hostname: '127.0.0.1'
                    port: 8080
                    protocol: 'http'
                    base: 'build/dev'
                    livereload: true

    grunt.registerTask 'hugo', (target) ->
        done = @async()
        args = ['--source=site', "--destination=../build/#{target}"]
        if target == 'dev'
            args.push '--baseUrl=http://127.0.0.1:8080'
            args.push '--buildDrafts=true'
            args.push '--buildFuture=true'
        hugo = require('child_process').spawn 'hugo', args, stdio: 'inherit'
        (hugo.on e, -> done(true)) for e in ['exit', 'error']

    grunt.loadNpmTasks plugin for plugin in [
        'grunt-contrib-coffee'
        'grunt-contrib-uglify'
        'grunt-contrib-copy'
        'grunt-contrib-less'
        'grunt-contrib-watch'
        'grunt-contrib-connect'
        'grunt-responsive-images'
    ]
    grunt.registerTask 'dev', ['less:dev', 'coffee', 'copy:coffee', 'responsive_images', 'hugo:dev']
    grunt.registerTask 'default', ['less:dist', 'coffee', 'copy:coffee', 'uglify', 'responsive_images', 'hugo:dist']
    grunt.registerTask 'edit', ['connect', 'watch']
