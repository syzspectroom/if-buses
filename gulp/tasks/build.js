var gulp        = require('gulp');
var runSequence = require('run-sequence');


// Build Production Files, the Default Task
gulp.task('build', function (cb) {
  runSequence('clean', [
    'browserify', 'coffeelint',
    'copyCssJsHtml', 'copyOther',
    'sass', 'images', 'jade'
  ], ['optimize'], cb);
});
