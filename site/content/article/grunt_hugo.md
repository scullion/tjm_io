+++
weight = 1
date = "2015-01-05T11:02:30Z"
draft = false

locations = ["blog", "articles"]
slug = "grunt-hugo"
title = "Grunt and Hugo: A Fast Iteration Cookbook"
description = "A selection of code snippets for building static site editing environments based on Grunt, Hugo, LESS and CoffeeScript."
image = "escher_eye"
enable_comments = true
classes = ["compact-code"]

[[article_menu.items]]
title = "Introduction"
id = "grunt-hugo"

    [[article_menu.items.items]]
    title = "Getting Started"

    [[article_menu.items.items]]
    title = "The Gruntfile"

[[article_menu.items]]
title = "Basics"
id = "building-the-site"

    [[article_menu.items.items]]
    title = "Building the Site"

    [[article_menu.items.items]]
    title = "Development Server"

    [[article_menu.items.items]]
    title = "Watching for Changes"

[[article_menu.items]]
title = "Tools"
id = "less"

    [[article_menu.items.items]]
    title = "LESS"

    [[article_menu.items.items]]
    title = "CoffeeScript"

    [[article_menu.items.items]]
    title = "Source Maps"

    [[article_menu.items.items]]
    title = "Minification"

    [[article_menu.items.items]]
    title = "Image Resizing"

[[article_menu.items]]
title = "Download"

+++

[Hugo]: http://gohugo.io/
[LESS]: http://lesscss.org/
[CoffeeScript]: http://coffeescript.org/
[LiveReload]: http://livereload.com/
[livereload.js]: https://github.com/livereload/livereload-js
[GraphicsMagick]: http://www.graphicsmagick.org/
[ImageMagick]: http://www.imagemagick.org/
[Grunt]: http://gruntjs.com
[npm]: https://www.npmjs.com/
[grunt-contrib-copy]: https://www.npmjs.com/package/grunt-contrib-copy
[grunt-contrib-watch]: https://www.npmjs.com/package/grunt-contrib-watch
[grunt-contrib-connect]: https://www.npmjs.com/package/grunt-contrib-connect
[grunt-contrib-less]: https://www.npmjs.com/package/grunt-contrib-less
[grunt-contrib-coffee]: https://www.npmjs.com/package/grunt-contrib-coffee
[grunt-contrib-uglify]: https://www.npmjs.com/package/grunt-contrib-uglify
[grunt-responsive-images]: http://www.andismith.com/grunt-responsive-images/
[less-plugin-clean-css]: https://www.npmjs.com/package/less-plugin-clean-css
[less-plugin-autoprefix]: https://www.npmjs.com/package/less-plugin-autoprefix

This is a selection of code snippets that can be used to assemble a nice live 
editing environment for static sites using [Grunt][]. The focus is on 
[Hugo][], [LESS][] and [CoffeeScript][], but most of the code could easily be 
repurposed for similar tools. In addition to the markup and script compilation, 
we'll add automatic image resizing using [grunt-responsive-images][].

The `Gruntfile` broken down here is in [CoffeeScript][] since that's what I 
happened to use, but it should be straightforward to transliterate into plain 
JavaScript if required. It can be downloaded [here](Gruntfile.coffee).

### Getting Started

First make sure [node.js](http://nodejs.org/) and [npm][] are installed. 
`npm` is bundled with the standard node.js binary installers available 
[here](http://nodejs.org/download/). 

Initialize a `package.json` and install the required plugins by running the 
following commands in your project directory. Feel free to omit plugins you 
don't need.

{{< highlight "bash" >}}
$ cd mysite
$ npm init
$ npm install grunt --save-dev
$ npm install grunt-contrib-watch --save-dev
$ npm install grunt-contrib-connect --save-dev
$ npm install grunt-contrib-copy --save-dev
$ npm install grunt-contrib-coffee --save-dev
$ npm install grunt-contrib-uglify --save-dev
$ npm install grunt-contrib-less --save-dev
$ npm install grunt-responsive-images --save-dev
{{< /highlight >}}

The <kbd>grunt</kbd> command comes from the `grunt-cli` package, so run 
`npm install -g grunt-cli` to install it globally if you haven't already.

All being well you'll now have a complete `package.json` than can be used to 
install the required packages at any time in the future via `npm install`. The 
commands above installed the packages as well as adding them to `package.json` 
so there's no need to do this now.

If `npm` complains about the site lacking a `README` file, add `"private": true` 
to `package.json` to make it stop. 

### The Gruntfile

Paste the following skeleton into a file called `Gruntfile.coffee` at the top of
the project. (Alternatively, start from the full 
[Gruntfile.coffee](Gruntfile.coffee) and delete the bits you don't need). This 
basic setup code loads the plugins and defines the main tasks exposed by the 
`Gruntfile`.

{{< highlight "coffeescript" >}}
module.exports = (grunt) ->
    grunt.initConfig
        pkg: grunt.file.readJSON('package.json')
        
        # PUT CONFIGURATION SECTIONS HERE

    grunt.loadNpmTasks plugin for plugin in [
        'grunt-contrib-watch'
        'grunt-contrib-connect'
        'grunt-contrib-copy'
        'grunt-contrib-coffee'
        'grunt-contrib-uglify'
        'grunt-contrib-less'
        'grunt-responsive-images'
    ]
    grunt.registerTask 'dev', [
        'less:dev', 
        'coffee', 
        'copy:coffee',
        'responsive_images', 
        'hugo:dev']
    grunt.registerTask 'default', [
        'less:dist', 
        'coffee', 
        'copy:coffee', 
        'uglify', 
        'responsive_images', 
        'hugo:dist']
    grunt.registerTask 'edit', ['connect', 'watch']
{{< /highlight >}}

Together these tasks form the command line interface for our system. They can
be used as follows.

<table>
    <tr>
        <td><kbd>grunt</kbd></td>
        <td>Builds the site for distribution in <code>build/dist</code>.</td>
    </tr>
    <tr>
        <td><kbd>grunt dev</kbd></td>
        <td>Builds the site for development in <code>build/dev</code>.</td>
    </tr>
    <tr>
        <td><kbd>grunt edit</kbd></td>
        <td>Starts the local server and watches the filesystem for changes. 
        The site can be viewed at <a href="http://127.0.0.1:8080/">http://127.0.0.1:8080/</a>.</td>
    </tr>
</table>

The sections below provide configurations for various tools that can 
be pasted into this basic `Gruntfile.coffee` and customized as required.

<!--more-->

### Building The Site

To keep things tidy, I've put the Hugo site into a subdirectory called `site` 
under the project root. The following code registers a task that runs `hugo` to 
compile this `site` directory, placing the rendered result in either `build/dev` or 
`build/dist` (for development and deployment builds respectively). The target is 
selected by referring to the task as `hugo:dev` or `hugo:dist`.

{{< highlight "coffeescript" >}}
grunt.registerTask 'hugo', (target) ->
    done = @async()
    args = ['--source=site', "--destination=../build/#{target}"]
    if target == 'dev'
        args.push '--baseUrl=http://127.0.0.1:8080'
        args.push '--buildDrafts=true'
        args.push '--buildFuture=true'
    hugo = require('child_process').spawn 'hugo', args, stdio: 'inherit'
    (hugo.on e, -> done(true)) for e in ['exit', 'error']
{{< /highlight >}}

In the `dev` configuration, which builds the site for live editing on a local 
server, it's important to supply the `--baseUrl` (`-b`) option to `hugo`. This
overrides the `BaseUrl` specified in the site's `config.toml` with the URL of
our local development server. Without such an override, Hugo will generate 
absolute URLs referring to the site's public server.

### Development Server

[Hugo](https://gohugo.io) comes with a built-in development web server usable 
via `hugo server`. While this is a good option for working on content alone, 
it's awkward to make the current version live-reload while working on CSS or
scripts.

For that reason we'll use [grunt-contrib-connect][] instead. This is a Grunt 
plugin that runs a static file server. The configuration below serves the 
file tree generated by Hugo in `build/dev`, and should be mostly 
self-explanatory.

{{< highlight "coffeescript" >}}
connect:
    mysite:
        options:
            hostname: '127.0.0.1'
            port: 8080
            protocol: 'http'
            base: 'build/dev'
            livereload: true
{{< /highlight >}}

The `livereload` option turns on a middleware that injects [livereload.js][] into 
HTML responses generated by the server. This script connects back to the server
on port 35729 and waits to be told that it should refresh the page. For this to 
work we'll need to be running a [LiveReload][] service on port 35729, which is 
the job of [grunt-contrib-watch][] as explained below.

### Watching for Changes

With a development server and a task to run `hugo` in place, the final component 
of a basic live editing environment is [grunt-contrib-watch][], which watches
the filesystem and runs Grunt tasks when something changes.

The configuration below simply watches for changes in the various directories 
containing source files (`site`, `less`, `coffee` and `img`), and runs the 
appropriate tool in response. 

Changes will cascade so that, for example, when the LESS compiler updates a 
stylesheet in `site/static/css`, [grunt-contrib-watch][] will notice and run 
`hugo` to rebuild the site, resulting in the new file being copied over to 
`build/dev`. This is perhaps not the most efficient arrangement, but it's 
straightforward, and Hugo is quick enough that running it on every change 
doesn't add much latency.

{{< highlight "coffeescript" >}}
watch:
    options:
        atBegin: true
        livereload: true
    less:
        files: ['less/*.less']
        tasks: 'less:dev'
    coffee:
        files: ['coffee/*.coffee']
        tasks: 'coffee'
    images:
        files: ['img/**']
        tasks: 'responsive_images'
    hugo:
        files: ['site/**']
        tasks: 'hugo:dev'
    all:
        files: ['Gruntfile.coffee']
        tasks: 'dev'
{{< /highlight >}}

The two options supplied to the `watch` task are:

- `livereload`, which tells [grunt-contrib-watch][] to run a [LiveReload][] service on 
    port 35729. Recall that we're using [grunt-contrib-connect][] to inject 
    [livereload.js][] into our HTML pages, and [livereload.js][] will connect 
    back to this service from the browser and refresh the page when stuff changes.
- `atBegin`, which causes all watch tasks to be run at startup, ensuring that 
    the site is up to date when we start editing.

<h3 id="less">LESS</h3>

To compile LESS to CSS we'll use the [grunt-contrib-less][] plugin.

{{< highlight "shell" >}}
$ npm install grunt-contrib-less --save-dev
$ npm install less-plugin-clean-css --save-dev
$ npm install less-plugin-autoprefix --save-dev
{{< /highlight >}}

The LESS compiler `lessc` supports plugins of its own, which provide a very 
convenient way of post-processing CSS. This configuration makes use of the
following two:

<table>
    <tr>
        <th><a class="identifier" href="https://www.npmjs.com/package/less-plugin-clean-css">less-plugin-clean-css</a></th>
        <td>Minifies CSS.</td>
    </tr>
    <tr>
        <th><a class="identifier" href="https://www.npmjs.com/package/less-plugin-autoprefix">less-plugin-autoprefix</a></th>
        <td>Adds vendor prefixed (<code>-webkit-</code>, <code>-moz-</code>, etc.) variants of CSS properties to improve browser
        compatibility.</td>
    </tr>
</table>

Here's the `less` configuration that runs `lessc` on our site's main
LESS file, `less/mysite.less`. It defines a pair of subtasks, `less:dev` and 
`less:dist`, the latter generating a prefixed and minified stylesheet for 
deployment.

{{< highlight "coffeescript" >}}
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
{{< /highlight >}}

The `browsers` option to [less-plugin-autoprefix][] determines the set of CSS 
properties to be prefixed, and should be set according to the level of 
compatibility required. See 
[the documentation](https://github.com/postcss/autoprefixer#browsers)
for details.

### CoffeeScript

Here we configure [grunt-contrib-coffee][] to compile scripts under the `coffee` 
directory and sandwich them into a single `.js` file, `site/static/js/mysite.js`. 
If using source maps the [grunt-contrib-copy][] plugin is also required, for 
reasons explained below.

{{< highlight "shell" >}}
$ npm install grunt-contrib-coffee --save-dev
$ npm install grunt-contrib-copy --save-dev
{{< /highlight >}}

This is the configuration block.

{{< highlight "coffeescript" >}}
coffee:
    options:
        join: true             # Concatenate before, not after compilation.
        sourceMap: true        # Make a source map.
        sourceRoot: '/coffee/' # URL debugger should use to download .coffee files.
        inline: true           # Embed coffee source inside the source map.
    build:
        src: ['coffee/a.coffee', 'coffee/b.coffee', /* ADD FILES HERE */]
        dest: 'site/static/js/mysite.js'
{{< /highlight >}}

Multiple `.coffee` files can be built by simply listing them in the `src` array.
It's inadvisable to use a wildcard (e.g. `coffee/*`), because the order in which
the files are yielded by the resulting glob, and thus the order in which they 
are concatenated, is undefined. Instead, list each file individually in the 
desired order.

The `join` option instructs the plugin to concatenate the `.coffee` files 
*before* passing them to the `coffee` compiler, rather than concatenating the 
resulting `.js` files after compilation. This is generally what is wanted 
because it allows the scripts to share a global scope.

#### Source Maps

[Source maps](http://www.html5rocks.com/en/tutorials/developertools/sourcemaps/)
are essential for a sane debugging experience. In the configuration above we've
turned them on using `sourceMap: true`, which causes the `coffee` compiler to
generate `mysite.js.map` alongside `mysite.js`.

By default source maps don't contain any actual source code. Instead they
refer to source files (in our case, the `.coffee` files) by relative path, and 
the debugger in the browser must download the source files as required.

This is an awkward arrangement because, of course, for the debugger to
download the `.coffee` files they have be made available on the server 
somewhere. An easier option is to have the compiler *embed* the source directly 
into the map by setting `inline: true`.

If you don't care about debugging minified JavaScript (a dubious proposition at
the best of times), I recommend setting `inline: true` and ignoring the rest of
this section. Source maps with embedded code are self-contained so there's no 
need to publish the `.coffee` files anywhere.

##### Publishing the `.coffee` Files

The disadvantage of `inline` is that `UglifyJS` seems incapable of using 
embedded CoffeeScript source when building a source map for its minified
JavaScript. If the sources are referenced externally (i.e. `inline` is set to
`false`), it works fine. 

If we don't embed the source code in the map, it's necessary to publish the 
`.coffee` files on the server somewhere. This can be achieved very simply by 
configuring [grunt-contrib-copy][] to copy our `.coffee` sources into the public 
site at `site/static/coffee`.

{{< highlight "coffeescript" >}}
copy:
    coffee:
        src: 'coffee/*'
        dest: 'site/static/'
{{< /highlight >}}

This makes the `coffee` directory accessible on the server at `/coffee`. Note 
that we've also set `sourceRoot` to `/coffee/`. This path is embedded in the
source map, and tells the debugger where to download referenced files.

#### Minification

In the `dist` build we'll use [grunt-contrib-uglify][] to minify `mysite.js`.

{{< highlight "coffeescript" >}}
uglify:
    options:
        sourceMap: true
        sourceMapIn: 'site/static/js/mysite.js.map'
    dist:
        src: 'site/static/js/mysite.js'
        dest: 'site/static/js/mysite.min.js'
{{< /highlight >}}

The `sourceMap` option tells `UglifyJS` to generate a source map for the 
minified script, and `sourceMapIn` provides it with the original map generated
by the `coffee` compiler. 

The rationale for providing the original map is that it allows the map for the 
compressed script to directly reference the `.coffee` source, instead of just 
the JavaScript generated by the `coffee` compiler, which makes for a nicer 
debugging experience. However, as described above, this doesn't work properly 
when the CoffeeScript is embedded with `inline`.

It's worth noting that even with a source map available, debugging minified
JavaScript is difficult because the minifier can fold many source lines into one 
to save space. If at all possible, debug using the unminified script.

### Image Resizing

A great convenience offered by platforms like Wordpress is automatic 
image resizing and cropping. The handy [grunt-responsive-images][] plugin can 
provide similar facilities in a static site workflow. 

The basic idea is to put source images into a directory called `img` at the
top of the project, and configure the plugin to generate multiple cropped 
and resized variants under `site/static/img`. Thanks to [grunt-contrib-watch][], 
the image processing happens automatically as soon as a new image is copied into 
`img`.

First make sure [grunt-responsive-images][] is installed.

{{< highlight "shell" >}}
$ npm install grunt-responsive-images --save-dev
{{< /highlight >}}

The actual image processing work is done by [ImageMagick][] or 
[GraphicsMagick][], so one of those must also be installed and available on
the system `PATH` for image resizing to work. It makes no difference which.

Here's the configuration block. See below for instructions on what to put in the
`sizes` array.

{{< highlight "coffeescript" >}}
responsive_images:
  process:
    options:
      engine: 'gm'
      separator: '_'
      newFilesOnly: true
      sizes: [ /* PUT IMAGE SPECIFICATIONS HERE */ ]
    files: [
      expand: true
      cwd: 'img'
      src: '**.{png,jpg,jpeg,gif}'
      dest: 'site/static/img'
    ]
{{< /highlight >}}

The important options to understand are:

<table>
    <tr>
        <th><code>engine</code></th>
        <td><code>gm</code> for GraphicsMagick, <code>im</code> for ImageMagick</td>
    </tr>
    <tr>
        <th><code>separator</code></th>
        <td>Delimiter used between the name stem and the suffix specified in
        the size definition.</td>
    </tr>
    <tr>
        <th><code>newFilesOnly</code></th>
        <td>Set to <code>false</code> to force regeneration.</td>
    </tr>
    <tr>
        <th><code>sizes</code></th>
        <td>Array of size specifications (see below).</td>
    </tr>
</table>

All that remains is to add a specification to the `sizes` array for each image
variant required. The following templates cover the most useful operations. 
Copy, paste and customize.

* **Copy the Source Image**

    Copies the source image, unmodified, into the destination directory. 

    {{< highlight "coffeescript" >}}{ rename: false, width: '100%', height: '100%' }{{< /highlight >}}

* **Crop to an Exact Size**

    Generates a thumbnail of exactly 64&times;64 pixels. Setting `aspectRatio` to 
    `false` enables cropping.

    {{< highlight "coffeescript" >}}{ name: '64x64', width: 64, height: 64, aspectRatio: false }{{< /highlight >}}

* **Proportional Scale** <span class="text-muted">(Single Axis Constraint)</span>

    Generates an image exactly 300px wide, with a height determined by the 
    source image's aspect ratio.

    {{< highlight "coffeescript" >}}{ name: '300', width: 300 }{{< /highlight >}}

* **Proportional Scale** <span class="text-muted">(Both Axes Constrained)</span>

    Scales the image down proportionally until it is neither wider than 400px 
    nor taller than 250px.

    {{< highlight "coffeescript" >}}{ name: '300', width: 400, height: 250, aspectRatio: true }{{< /highlight >}}

Full documentation for [grunt-responsive-images][] is 
[here](http://www.andismith.com/grunt-responsive-images/).

### Download

The full `Gruntfile.coffee` is available [here](Gruntfile.coffee). 

I hope you found this little guide helpful. Corrections, comments and questions 
are always welcome.
