'use strict';

const 
    path = require('path'),
    spawn = require('child_process').spawn,

    mergeStream = require('merge-stream'),

	gulp = require('gulp'),
    gutil = require('gulp-util'),
    rename = require('gulp-rename'),
    less = require('gulp-less'),
    cleancss = require('gulp-clean-css'),
    autoprefix = require('gulp-autoprefixer'),
    sourcemaps = require('gulp-sourcemaps'),
    concat = require('gulp-concat'),
    uglify = require('gulp-uglify'),
    coffee = require('gulp-coffee'),
    imageResize = require('gulp-image-resize'),
	
	browserSync = require('browser-sync').create();

function lessHelper(interactive, target) {
    /* The purpose of this is to allow the LESS tasks to succeed even in the 
     * presence of a syntax error. Without it the watch task aborts every time 
     * we make a typo. */
    const compiler = less().on('error', (e) => {
        gutil.log(e);
        if (!interactive)
            compiler.end();
    });
    
    const outputPath = path.join('build', target, 'css');
    let stream = gulp.src('less/tjm_io.less')
        .pipe(compiler)
        .pipe(autoprefix('last 2 version', 'ie 8', 'ie 9'))
        .pipe(gulp.dest(outputPath));
    if (target === 'dist') {
        stream = stream.pipe(cleancss())
	        .pipe(rename({ extname: '.min.css' }))
	        .pipe(gulp.dest(outputPath));
    }
    if (interactive)
        stream = stream.pipe(browserSync.stream());
    return stream;
}

gulp.task('less:dev', () => lessHelper(true, 'dev'));
gulp.task('less:dist', () => lessHelper(true, 'dist'));

function jsHelper(target) {
	const outputPath = path.join('build', target, 'js');
	let stream = gulp.src('coffee/tjm_io.coffee')
		.pipe(coffee())
		.pipe(gulp.dest(outputPath));
	if (target === 'dist') {
		stream = stream.pipe(uglify())
			.pipe(rename({ extname: '.min.js'}))
			.pipe(gulp.dest(outputPath));
	}
	return stream;
}

gulp.task('js:dev', (done) => jsHelper('dev'));
gulp.task('js:dist', (done) => jsHelper('dist'));

gulp.task('js:dev:reload', ['js:dev'], (done) => { browserSync.reload(); done(); });
gulp.task('js:dist:reload', ['js:dist'], (done) => { browserSync.reload(); done(); });

function hugoHelper(done, target) {
	const rootPath = __dirname;
	const sourcePath = path.join(rootPath, "site");
	const destPath = path.join(rootPath, "build", target);

	const args = [
		'--source', sourcePath, 
		'--destination', destPath
	];

	if (target === 'dev') {
		args.push('--baseUrl', 'http://localhost');
		args.push('--buildDrafts');
		args.push('--buildFuture');
	}

	const hugo = spawn("hugo", args, { stdio: 'inherit' });

	hugo.on('close', (exitCode) => {
		if (exitCode === 0)
			browserSync.reload();
		done();
	}).on('error', (e) => {
		done(e);
	});
}

gulp.task('hugo:dev', (done) => hugoHelper(done, 'dev'));
gulp.task('hugo:dist', (done) => hugoHelper(done, 'dist'));

function imageResizeHelper(target) {
	const sourceRoot = path.join(__dirname, 'img');
	const destRoot = path.join(__dirname, 'build', target, 'img')
	const sourcePattern = path.join(sourceRoot, '**/*.+(jpg|jpeg|png|gif)');

    const specs = [
    	{ /* Copy through the original. */ },
    	{ width: 64, height: 64, crop: true, rename: { suffix: '_64x64'} },
    	{ width: 128, height: 128, crop: true, rename: { suffix: '_128x128'} },
    	{ width: 300, rename: { suffix: '_300'} },
    ];

	const files = gulp.src(sourcePattern);
	const merged = mergeStream();
	for (const spec of specs) {
		let stream = files.pipe(imageResize(spec));
		if (spec.rename)
			stream = stream.pipe(rename(spec.rename));
		stream = stream.pipe(gulp.dest(destRoot));
		merged.add(stream);
	}

	return merged;
}

gulp.task('images:dev', () => imageResizeHelper('dev'));
gulp.task('images:dist', () => imageResizeHelper('dist'));

function serverHelper(target) {
	browserSync.init({
        port: 80,
        server: {
            baseDir: path.join('build', target),
            index: "index.html",
        }
    });

    gulp.watch("less/**/*.less", ['less:' + target]);
    gulp.watch("+(js|coffee)/**/*", ['js:' + target + ':reload']);
    gulp.watch("img/**/*", ['images:' + target]);
    gulp.watch("site/**/*", ['hugo:' + target]);
}

gulp.task('serve:dev', ['dev'], (done) => serverHelper('dev'));
gulp.task('serve:dist', ['dist'], (done) => serverHelper('dist'));

gulp.task('dev', ['less:dev', 'js:dev', 'hugo:dev']);
gulp.task('dist', ['less:dist', 'js:dist', 'hugo:dist']);

gulp.task('default', ['serve:dev']);
