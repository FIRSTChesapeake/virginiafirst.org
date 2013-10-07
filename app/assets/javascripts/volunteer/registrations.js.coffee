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
      event = $(this).closest(".event")
      event.toggleClass("selected")
      if this.checked
        event.find(".event-option").removeAttr('disabled')
        event.find(".event-option").closest("label").removeClass("disabled")
      else
        event.find(".event-option").attr("disabled", true)
        event.find(".event-option").closest("label").addClass("disabled")

