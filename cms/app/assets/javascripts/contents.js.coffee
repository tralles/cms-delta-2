
jQuery ->
  $(document).on 'ready page:load', ->
    
    if $('#docpoover')
      if $("textarea.inline_documents").length > 0 
  
        $("textarea.inline_documents").each (index) ->
          $(this).after('<div class="documentactions"><span class="documentaction btn btn-mini btn-info" rel="'+$(this).attr('id')+'"><i class="icon-picture" /> Dokumente</span></div>')
  
        $('.documentaction').popover( { trigger: 'manual', title: 'Dokumente', html: true, content: $('#docpoover').html() } )
        $('.documentaction').click ->
          $(this).popover('toggle')
          $('.popover-content .line').draggable( { cursor: 'move', revert: "invalid", containment: "document", helper: "clone", cursor: "move" } )
          return false
          
      $("textarea.inline_documents").droppable
        accept: ".line"
        activeClass: "custom-state-active"
        drop: (event, ui) ->
          $(this).insertAtCaret( '[img:'+ui.draggable.attr('rel')+']' )
          # ui
          
          
