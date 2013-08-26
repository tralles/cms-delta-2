# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $(document).on 'ready page:load', ->

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


