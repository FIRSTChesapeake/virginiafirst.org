# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  if $("#edit_experience_profile").length > 0
    $(".inline-team input:checkbox").each (index, value) ->
      parent = $(value).parents(".inline-team")
      checked = $(value).is(':checked')
      parent.children(".team-input").toggle(checked)

    $(".inline-team input:checkbox").click (e) ->
      parent = $(this).parents(".inline-team")
      $(parent).children(".team-input").toggle().focus()

  $("#preferred_roles_accordion").collapse().height('auto');

$ ->
  $("#location_name").on 'keypress', (e) ->
    if e.which == 13
      e.preventDefault()
      $("#add_mentor_location_button").click()

  $("#mentor_locations").on 'cocoon:after-insert', (e, item) ->
    $(item).find("label").text $("#location_name").val()
    $(item).find(".name-field").val $("#location_name").val()
    $("#location_name").val("")
