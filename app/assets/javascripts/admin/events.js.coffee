# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  if $("#event_form_tabs").length > 0
    $("#event_form_tabs").click (e) ->
      e.preventDefault()
      $(this).tab("show")


$ ->
  $('form').on 'click', '.remove-fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('div').hide()
    event.preventDefault()

  $('form').on 'click', '.add-fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    selection = $(this).data('selection')
    source = $(this).data('source').replace(':id:', $(selection).val())
    target = $(this).data('container')
    $(target).append($(this).data('fields').replace(regexp, time))

    $.getJSON source, (data) ->
      container = "#position_" + time
      $(container + " input[type=hidden]").val(data["id"])
      $(container + " span").html(data["title"])
      $(container + " input[type=text]").val(data["default_number_needed"])
      $("option[value='" + $(selection).val() + "']", selection).remove()

    event.preventDefault()
