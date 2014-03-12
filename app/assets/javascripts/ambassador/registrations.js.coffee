# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  scheduler.date.workweek_start = -> new Date("March 20, 2014")
  scheduler.date.get_workweek_end = -> new Date("March 22, 2014")
  scheduler.date.add_workweek = scheduler.date.add_week

  scheduler.attachEvent "onTemplatesReady", ->
    scheduler.templates.workweek_date = scheduler.templates.week_date
    scheduler.templates.workweek_scale_date = scheduler.templates.week_scale_date

  $("#scheduler_here").dhx_scheduler
    xml_date: "%Y-%m-%d %H:%i"
    first_hour: 8
    last_hour: 17
    time_step: 30
    date: new Date()
    mode: "week"
    icons_select: ["icon_delete"]

