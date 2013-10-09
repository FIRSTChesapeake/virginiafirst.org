# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  if $("#volunteer_registration_form").length > 0
    $("input.event-checkbox").each (index, value) ->
      isSelected = $(this).is(":checked")
      event = $(this).closest(".event")
      event.addClass("selected") if isSelected
      event.find(".event-option").attr('disabled', !isSelected)
      event.find(".event-option").closest("label").addClass("disabled") if !isSelected

    $("input.event-checkbox").change ->
      destroy = $(this).attr("name").substring(0, 46) + "[_destroy]"
      destroy_id = $(this).attr("id").substring(0, 44) + "_destroy"
      event = $(this).closest(".event")
      event.toggleClass("selected")
      if this.checked
        event.find(".event-option").removeAttr('disabled')
        event.find(".event-option").closest("label").removeClass("disabled")
        $("#" + destroy_id).remove()
      else
        event.find(".event-option").attr("disabled", true)
        event.find(".event-option").closest("label").addClass("disabled")
        event.append('<input type="hidden" id="' + destroy_id + '" name="' + destroy + '" value="true"/>')

