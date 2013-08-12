# jQuery ->
#   $('#tree li').sortable
#     handle: '.handle'
#     grid: [ 5,5 ]
#     opacity: 0.7
#     helper: "clone"
#     update: ->
#       $.post($(this).data('update-url'), $(this).sortable('serialize'))

jQuery ->
  $(document).on 'ready page:load', ->
    helper = (e, tr) ->
      $originals = tr.children()
      $helper = tr.clone()
      $helper.children().each (index) ->
        $(this).width $originals.eq(index).width()
    
      $helper
  
    $('tbody.sortable').sortable
      handle: '.handle'
      opacity: 0.7
      helper: helper
      forceHelperSize: true
      forcePlaceholderSize: true
      cursor: 'crosshair'
      items: 'tr'
      axis: 'y'
      update: ->
        $.post($(this).data('update-url'), $(this).sortable('serialize'))
