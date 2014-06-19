$("#contentrelationwindow").remove()
$("body").append "<%= j( render :partial => 'contents/edit_modal' )  %>"
$("#contentrelationwindow").modal
  backdrop: true
  keyboard: false

$(".datepicker").datepicker
  format: "yyyy-mm-dd"
  weekStart: 1
  calendarWeeks: true
  language: "de"

$(".timepicker").timepicker
  showMeridian: false
  template: false
  showInputs: false
  defaultTime: false
  minuteStep: 15

$(".typeahead").typeahead()
$("#contentrelationwindow form").on "submit", ->
  allok = true
  if $(this).find(".required").length > 0
    $(this).find(".required").each ->
      if $(this).val().length is 0 and ($(this).is("input") or $(this).is("textarea"))
        allok = false
        $(this).parent().parent().addClass "error"
      else
        $(this).parent().parent().removeClass "error"
      return

  if allok
    NProgress.start()
    NProgress.set 0.8
  else
    false
  return

$("#contentrelationwindow textarea.redactor").redactor
  lang: "de"
  buttons: [
    "html"
    "|"
    "bold"
    "italic"
    "deleted"
    "|"
    "unorderedlist"
    "orderedlist"
    "outdent"
    "indent"
    "|"
    "table"
    "link"
    "|"
    "fontcolor"
    "backcolor"
    "|"
    "horizontalrule"
  ]
  minHeight: 200
  autoresize: false

$("#contentrelationwindow textarea.markdown").pagedownBootstrap
  sanatize: true
  help: ->
    window.open "https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet"
    false

  hooks: []











$(".ctsuggestion").typeahead
  minLength:3,
  source: (query, process) ->
    $.ajax
      url: $('.ctsuggestion').attr("rel")
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
            id: item.id

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
    alert(item.id )
    # window.location.href = item.href
    # $("#search").attr "href", item.href
    # item.title














NProgress.done()
