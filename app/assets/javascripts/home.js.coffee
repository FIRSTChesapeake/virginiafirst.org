# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

infoWindowContent = (event) ->
  starts_at = moment(event.starts_at).format("dddd, MMMM M YYYY @ hh:mm a")
  """
      <div id="content">
        <div id="siteNotice">
        </div>
        <h4>#{event.name}</h4>
        <p>
          <strong>#{starts_at}</strong><br>
          <address>
            #{event.venue}<br>
            #{event.street}<br>
            #{event.city}, #{event.state} #{event.zip}
          </address>
        </p>
      </div>
        """

initialize_events_map = ->
  mapOptions =
    center: new google.maps.LatLng(-34.397, 150.644)
    zoom: 8
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(document.getElementById("upcoming_events_map_canvas"),
                                mapOptions)
  events = $("#upcoming_events_map_canvas").data("events")
  bounds = new google.maps.LatLngBounds()
  for event in events
    latlng = new google.maps.LatLng event.latitude, event.longitude
    bounds.extend(latlng);
    marker = new google.maps.Marker
      position: latlng
      map: map
    marker.infoWindow = new google.maps.InfoWindow
        content: infoWindowContent(event)
    google.maps.event.addListener marker, 'click', ->
        this.infoWindow.open map, this

  map.fitBounds(bounds)
  map.panToBounds(bounds)

$ ->
  if $("#upcoming_events_map_canvas").length > 0
    initialize_events_map()
