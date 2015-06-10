class BusStop
  constructor: (params) ->
    @map = params.map
    @routes = params.routes
    @busStops = []
    @layerGroups = []

  addStop: (data = {}) ->
    busStop = L.circle([
      data.lat
      data.lon
    ], data.radius,
      weight: data.weight || 2
      color: data.color || ''
      fillColor: data.fillColor || '#f03'
      fillOpacity: data.fillOpacity || 0.5).bindPopup(data.title || 'bus stop')
    @busStops[data.routeId] ||= []
    @busStops[data.routeId].push busStop

  parseData: (busStopsInfo) ->
    for stop in busStopsInfo.values
      @addStop
        lat: stop.lonlatCenter[1] / 1000000
        lon: stop.lonlatCenter[0] / 1000000
        radius: stop.radius
        title: stop.name
        routeId: stop.routeId
        fillColor: @routes.getFillColorById(stop.routeId)
        color: @routes.getOutLineColorById(stop.routeId)
    for key, data of @busStops
      @layerGroups[@routes.getNameById(key)] = L.layerGroup(data)
    L.control.layers(@layerGroups).addTo(@map.leafletMap)

module.exports = BusStop
