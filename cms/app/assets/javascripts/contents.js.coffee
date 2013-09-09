
jQuery ->
  $(document).on 'ready page:load', ->
    
    if $('#docpoover')
      if $("textarea.inline_documents").length > 0 
  
        $("textarea.inline_documents").each (index) ->
          $(".documentactions").remove();
          $(this).after "<div class=\"documentactions\"><span class=\"documentaction btn btn-mini btn-info\" rel=\"" + $(this).attr("id") + "\"><i class=\"icon-picture\" /> Dokumente</span></div>"  if $("#docpoover .line").length > 0
  
        $('.documentaction').popover( { trigger: 'manual', title: 'Dokumente', html: true, content: $('#docpoover').html() } )
        $('.documentaction').click ->
          $(this).popover('toggle')
          $('.popover-content .line').draggable( { cursor: 'move', revert: "invalid", containment: "document", helper: "clone" } )
          return false
          
      $("textarea.inline_documents").droppable
        accept: ".line"
        activeClass: "custom-state-active"
        drop: (event, ui) ->
          target = $(this)
          width = 0
          align = false
          $('#addimageinfo').remove() if($('#addimageinfo').length > 0)
          $('body').append('<div id="addimageinfo" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <h3 id="myModalLabel">Bild-Eigenschaften</h3>
  </div>
  <div class="modal-body">
    <form class="form-horizontal" id="imageproperties">
    
      <div class="control-group">
        <label class="control-label" for="width">Bild-Breite</label>
        <div class="controls">
          <input type="number" id="width" placeholder="Bitte eine Ziffer eingeben">
        </div>
      </div>
      
      <div class="control-group">
        <label class="control-label" for="align">Bild-Ausrichtung</label>
        <div class="controls">
          <select id="align">
            <option value="">Ohne</option>
            <option value="left">Bild Links : Textumfluss Rechts</option>
            <option value="right">Bild Rechts : Textumfluss Links</option>
          </select>
        </div>
      </div>
    </form>
  </div>
  <div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Übernehmen</button>
  </div>
</div>');
          $('#addimageinfo').modal();
          $("#addimageinfo").on "hide", ->
            width = $('#imageproperties #width').val()
            align = $('#imageproperties #align').val()
            if width and align
              target.insertAtCaret "[img:" + ui.draggable.attr("rel") + ":" + width + ":" + align + "]"
            else if align
              target.insertAtCaret "[img:" + ui.draggable.attr("rel") + ":0:" + align + "]"
            else if width
              target.insertAtCaret "[img:" + ui.draggable.attr("rel") + ":" + width + "]"
            else
              target.insertAtCaret "[img:" + ui.draggable.attr("rel") + "]"

          
          # ui
          
          
