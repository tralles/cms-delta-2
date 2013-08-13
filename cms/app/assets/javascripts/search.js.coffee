
jQuery ->
  $(document).on 'ready page:load', ->

    $("#search").typeahead source: (query, process) ->
      $.post $("#search").attr('rel'), 
        query: query
        (data) ->
          process JSON.parse(data)
    
