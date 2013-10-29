# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.add_form').click (event) ->
    target = $(this).data('target')
    $(target).append($(this).data('form'))
    event.preventDefault()

  $('.cancel-form').on 'click', (event) ->
    $(this).closest('form').remove()
    event.preventDefault()