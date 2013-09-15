
jQuery ->
  $(document).on 'ready page:load', ->

    $("#search").typeahead
      minLength:3,
      source: (query, process) ->
        $.ajax
          url: $("#search").attr("rel")
          type: "POST"
          data: "query=" + query
          dataType: "JSON"
          async: true
          success: (data) ->            
            NProgress.done()
            resultList = data.map((item) ->
              link =
                href: item.href
                title: item.title
    
              JSON.stringify link
            )
            process resultList
    
    
      matcher: (obj) ->
        NProgress.done()
        item = JSON.parse(obj)
        ~item.title.toLowerCase().indexOf(@query.toLowerCase())
    
      #sorter: (items) ->
      #  NProgress.done()
      #  beginswith = []
      #  caseSensitive = []
      #  caseInsensitive = []
      #  item = undefined
      #  while link = items.shift()
      #    item = JSON.parse(link)
      #    unless item.title.toLowerCase().indexOf(@query.toLowerCase())
      #      beginswith.push JSON.stringify(item)
      #    else if ~item.name.indexOf(@query)
      #      caseSensitive.push JSON.stringify(item)
      #    else
      #      caseInsensitive.push JSON.stringify(item)
      #  beginswith.concat caseSensitive, caseInsensitive
    
      highlighter: (link) ->      
        NProgress.done()
        item = JSON.parse(link)
        query = @query.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, "\\$&")
        item.title.replace new RegExp("(" + query + ")", "ig"), ($1, match) ->
          "<strong>" + match + "</strong>"
    
    
      updater: (link) ->
        NProgress.done()
        item = JSON.parse(link)
        window.location.href = item.href
        # $("#search").attr "href", item.href
        item.title
