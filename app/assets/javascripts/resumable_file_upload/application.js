// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require_tree .

window.initializeResumableFileUpload = function() {
  $('.resumable-file-upload:not(.loaded)').each(function() {
    console.log(this)

    var r = new Resumable({
      target: '/upload/chunk',
	    headers: { 'X-CSRF-Token' : $('meta[name="csrf-token"]').attr('content') }
    });

    r.assignBrowse($('.browse_button', this).get(0));
    r.assignDrop($('.drop_target', this).get(0));

    $('.pause_button', this).on('click', function() {
      r.pause();
    });

    $('.resume_button', this).on('click', function () {
      r.upload();
    });

    $('.cancel_button', this).on('click', function () {
      r.cancel();
    });

    r.on('fileAdded', function (file) {
      console.log('fileAdded', file, this);
    });

    r.on('fileProgress', function (file) {
      console.log('fileProgress', file, this);
    });

    r.on('fileSuccess', function (file, message) {
      console.log('fileSuccess', file, message, this);
      // todo: input wijzigen
    });

    r.on('fileError', function (file, message) {
      console.log('fileError', file, message, this);
      // todo: melding geven
    });

    r.on('cancel', function () {
      console.log('cancel', this);
    });

  })
}

$(document).on('turbolinks:load', window.initializeResumableFileUpload)
