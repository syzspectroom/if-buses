class Ui
  constructor: (params)->
    @currentVisibleRouteId;
    @routes = params.routes
    @ways = params.ways
    @busStops = params.busStops
    @container = document.getElementById(params.containerId)
    @buildControls()

  buildControls: ->
    for routeId, route of @routes.data

      e = document.createElement 'a'
      e.innerHTML = route.name
      e.className = "item"
      e.href = "#"
      e.dataset.routeId = route.id
      e.onclick = (e)=>
        if @currentVisibleRouteId
          @busStops.hideStops @currentVisibleRouteId
          @ways.hideRoute @currentVisibleRouteId
          removeClass document.querySelectorAll('.item'), 'active'
        link = e.currentTarget
        @currentVisibleRouteId = link.dataset.routeId
        addClass link, 'active'
        @busStops.drawStops @currentVisibleRouteId
        @ways.drawRoute @currentVisibleRouteId
        @ways.centerMap @currentVisibleRouteId
      @container.appendChild e

module.exports = Ui

addClass = (el, className)->

  if el.classList
    el.classList.add className
  else
    el.className += ' ' + className

removeClass = (el, className)->

  if el instanceof NodeList
    for cel in el
      removeClass(cel, className)
  else
    if el.classList
      el.classList.remove className
    else
      el.className = el.className.replace(new RegExp('(^|\\b)' + className.split(' ').join('|') + '(\\b|$)', 'gi'), ' ')
