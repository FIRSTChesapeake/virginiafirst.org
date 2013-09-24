# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  if $("#volunteer_registration_form").length > 0
    $("input[name='profile\[volunteer_event_ids\]\[\]']").each (index, value) ->
      isSelected = $(this).is(":checked")
      $(this).closest(".event").addClass("selected") if isSelected

    $("input[name='profile\[volunteer_event_ids\]\[\]']").change ->
      $(this).closest(".event").toggleClass("selected")
