module.exports = (grunt) ->
    grunt.initConfig
        pkg: grunt.file.readJSON('package.json')
        less:
            dev:
                paths: ['less/']
                src: ['less/mysite.less']
                dest: 'site/static/css/mysite.css'
            dist:
                paths: ['less/']
                src: ['less/mysite.less']
                dest: 'site/static/css/mysite.min.css'
                options:
                    plugins: [
                        new (require 'less-plugin-autoprefix') browsers: ['> 0.1%']
                        new (require 'less-plugin-clean-css') {}
                    ]
        coffee:
            options:
                join: true             # Concatenate before, not after compilation.
                sourceMap: true        # Make a source map.
                sourceRoot: '/coffee/' # URL debugger should use to download .coffee files.
                inline: true           # Embed coffee source inside the source map.
            build:
                src: 'coffee/mysite.coffee'
                dest: 'site/static/js/mysite.js'
        uglify:
            options:
                sourceMap: true
                sourceMapIn: 'site/static/js/mysite.js.map'
            dist:
                src: 'site/static/js/mysite.js'
                dest: 'site/static/js/mysite.min.js'
        copy:
            # This task is not required if `inline` source maps are used.
            coffee:
                src: 'coffee/*'
                dest: 'site/static/'
        responsive_images:
            process:
                options:
                    engine: 'gm'
                    separator: '_'
                    sizes: [
                        { rename: false, width: '100%', height: '100%' }                # Copy the source.
                        { name: '64x64', width: 64, height: 64, aspectRatio: false }    # Exact 64x64 via cropping.
                        { name: '300', width: 300, aspectRatio: true }                  # At most 300px wide.
                        { name: '400x250', width: 400, height: 250, aspectRatio: true } # At most 400px wide and 250px tall.
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
            mysite:
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
