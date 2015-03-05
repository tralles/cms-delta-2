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
//= require jquery-ui
//= require jquery_ujs
//= require raphael
//= require morris
//= require turbolinks
//= require bootstrap
//= require_tree .


// require jquery.ui.all






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


  $('textarea.autosize').autosize();

  $("textarea.markdown").pagedownBootstrap({
	'sanatize': true,
	'help': function () { window.open('https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet'); return false; },
	'hooks': [
	]
});

  $("select").chosen({disable_search_threshold: 10, width: "100%"});

  $('[rel=tooltip]').tooltip();

  hljs.initHighlightingOnLoad();


  if( $('a.diffylink') )
  {
    $('a.diffylink').on('click', function(){
      $('.diffycode').hide();
      $('.diffylink').show();

      rel = $(this).attr('rel');
      $('#link'+rel).hide();
      $('#'+rel).show();
    });
  }

  if( $('textarea.aceditor').length > 0 && $('#aceditor').length > 0 )
  {
    var editor = ace.edit("aceditor");
    var textarea = $('textarea.aceditor')

    $('textarea.aceditor').closest('.control-group').hide();

    editor.getSession().setValue(textarea.val());
    editor.getSession().setTabSize(2);

    if($('textarea.aceditor').attr('mode') == 'css') { editor.session.setMode("ace/mode/css"); }
    else { editor.session.setMode("ace/mode/html_ruby"); }

    editor.setTheme("ace/theme/twilight");


    editor.setOptions({
      maxLines: Infinity,
      showInvisibles: true,
      showFoldWidgets: true,
      fontSize: 10
    });

    editor.getSession().on('change', function(){
      textarea.val(editor.getSession().getValue());
    });

    function smit()
    {
      $('.form-horizontal').submit()
      return false;
    }



    $(document).on('keydown', null, 'ctrl+s', smit );
    $(document).on('keydown', null, 'meta+s', smit );

    $('#aceditor *').on('keydown', null, 'ctrl+s', smit );
    $('#aceditor *').on('keydown', null, 'meta+s', smit );

  }


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
