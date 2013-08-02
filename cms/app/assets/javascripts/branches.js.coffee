# jQuery ->
#   $('#tree li').sortable
#     handle: '.handle'
#     grid: [ 5,5 ]
#     opacity: 0.7
#     helper: "clone"
#     update: ->
#       $.post($(this).data('update-url'), $(this).sortable('serialize'))
