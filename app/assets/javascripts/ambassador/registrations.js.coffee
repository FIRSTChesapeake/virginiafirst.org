# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  scheduler.attachEvent "onTemplatesReady", ->
    scheduler.date.workweek_start = -> new Date("March 20, 2014")
    scheduler.date.get_workweek_end = (start_date) ->
      scheduler.date.add(start_date,3,"day")
    scheduler.date.add_workweek= (date,inc) ->
      scheduler.date.add(date,inc*7,"day")
    scheduler.templates.workweek_date = scheduler.templates.week_date
    scheduler.templates.workweek_scale_date = scheduler.templates.week_scale_date

  scheduler.attachEvent "onTemplatesReady", ->
    scheduler.templates.event_text=(start,end,event) -> ""

  scheduler.init("scheduler_here",new Date(2010,0,6),"workweek")

  $("#scheduler_here").dhx_scheduler
    xml_date: "%Y-%m-%d %H:%i"
    first_hour: 8
    last_hour: 17
    time_step: 30
    date: new Date()
    mode: "workweek"
    icons_select: ["icon_delete"]

