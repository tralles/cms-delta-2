// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .







initalize = function() {

	// delegate calls to data-toggle="lightbox"
  $('*[data-toggle="lightbox"]').off('click');

  $('*[data-toggle="lightbox"]').on('click', function(event) {
    event.preventDefault();
    $(this).ekkoLightbox();
    return false;
  });


  $('.res img').addClass('img-responsive');

  $('.tabbable .tab a').on('click', function(e) {
    e.preventDefault();
    $(this).tab('show');
  });

}

$(document).ready(initalize);
$(document).on('page:load', initalize);
$(document).on('page:change', initalize);
