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
//= require jquery.ui.all
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .







jQuery.fn.extend({
insertAtCaret: function(myValue){
  return this.each(function(i) {
    if (document.selection) {
      //For browsers like Internet Explorer
      this.focus();
      sel = document.selection.createRange();
      sel.text = myValue;
      this.focus();
    }
    else if (this.selectionStart || this.selectionStart == '0') {
      //For browsers like Firefox and Webkit based
      var startPos = this.selectionStart;
      var endPos = this.selectionEnd;
      var scrollTop = this.scrollTop;
      this.value = this.value.substring(0, startPos)+myValue+this.value.substring(endPos,this.value.length);
      this.focus();
      this.selectionStart = startPos + myValue.length;
      this.selectionEnd = startPos + myValue.length;
      this.scrollTop = scrollTop;
    } else {
      this.value += myValue;
      this.focus();
    }
  })
}
});





$(document).on('ready page:load', function() {

  $('textarea.redactor').redactor({ lang: 'de', 
                          buttons: ['html', '|', 
                                    'bold', 'italic', 'deleted', '|', 
                                    'unorderedlist', 'orderedlist', 'outdent', 'indent', '|',
                                    'table', 'link', '|',
                                    'fontcolor', 'backcolor', '|', 
                                    'horizontalrule'],
                          minHeight: 200,
                          autoresize: false
                        });
                        


	$('form').on('submit',   function() { 
	  allok = true;

	  if($(this).find('.required').length > 0)
	  {
  	  $(this).find('.required').each(function(){ 
          if($(this).val().length == 0 && ($(this).is('input') || $(this).is('textarea') ))
          {
      	    allok = false;  
            $(this).parent().parent().addClass('error');
            $(this).parent().addClass('error');
          }
          else
          {
            $(this).parent().parent().removeClass('error');
            $(this).parent().removeClass('error');
          }
        });
      }

    if(allok)
    {
	    NProgress.start(); NProgress.set(0.8); 
	  }
	  else
	  {
      return false;
	  }
  
  });
  
  
  $( document ).ajaxStart(function() {
    NProgress.start();
    NProgress.set(0.5);
  });
  
  
  $( document ).ajaxStop(function() {
    NProgress.done();
    NProgress.remove();
  });

});

$(document).on('page:fetch',   function() { NProgress.start(); NProgress.set(0.8); });
$(document).on('page:change',  function() { NProgress.done(); });
$(document).on('page:restore', function() { NProgress.remove(); });




