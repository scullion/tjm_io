addCORSMiddleware = (connect, options, middlewares) ->
    middlewares.unshift (req, res, next) ->
        res.setHeader 'Access-Control-Allow-Origin', '*'
        next()
    middlewares

module.exports = (grunt) ->
    grunt.initConfig
        pkg: grunt.file.readJSON('package.json')
        less:
            dev:
                paths: ['less/']
                src: ['less/skeleton.less']
                dest: 'site/static/css/skeleton.css'
            dist:
                paths: ['less/']
                src: ['less/skeleton.less']
                dest: 'site/static/css/skeleton.min.css'
                options:
                    plugins: [new (require 'less-plugin-clean-css') {}]

        coffee:
            dev:
                src: ['coffee/*.coffee']
                dest: 'site/static/js/skeleton.js'
            dist:
                src: ['coffee/*.coffee']
                dest: 'site/static/js/skeleton.min.js'
                options:
                    sourceMap: true
        responsive_images:
            process:
                options:
                    engine: 'gm'
                    separator: '_'
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
                tasks: 'coffee:dev'
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
            site:
                options:
                    hostname: '127.0.0.1'
                    port: 8080
                    protocol: 'http'
                    base: 'build/dev'
                    livereload: true
                    middleware: addCORSMiddleware

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
        'grunt-contrib-less'
        'grunt-contrib-watch'
        'grunt-contrib-connect'
        'grunt-responsive-images'
    ]
    grunt.registerTask 'dev', ['less:dev', 'coffee:dev', 'responsive_images', 'hugo:dev']
    grunt.registerTask 'default', ['less:dist', 'coffee:dist', 'responsive_images', 'hugo:dist']
    grunt.registerTask 'edit', ['connect', 'watch']
