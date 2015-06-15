class BusStop
  constructor: (params) ->
    @map = params.map
    @routes = params.routes
    @busStops = []
    @layerGroups = []
    @raw = []

  getByRouteAndId: (params)->
    @raw[params.routeId][params.zoneId]

  getCordsRouteAndId: (params)->
    stop = @getByRouteAndId(params)
    [ stop.lonlatCenter[1] / 1000000, stop.lonlatCenter[0] / 1000000 ]

  addStop: (data = {}) ->
    busStop = L.circle([
      data.lat
      data.lon
    ], data.radius,
      weight: data.weight || 3
      color: data.color || ''
      fillColor: data.fillColor || '#f03'
      fillOpacity: data.fillOpacity || 0.8).bindPopup(data.title || 'bus stop')
    @busStops[data.routeId] ||= []
    @busStops[data.routeId].push busStop


  parseData: (busStopsData) ->
    for stop in busStopsData.values

      @raw[stop.routeId] ||= []
      @raw[stop.routeId][stop.id] = stop

      @addStop
        lat: stop.lonlatCenter[1] / 1000000
        lon: stop.lonlatCenter[0] / 1000000
        radius: stop.radius
        title: stop.name
        id: stop.id
        routeId: stop.routeId
        fillColor: @routes.getFillColorById(stop.routeId)
        color: @routes.getOutLineColorById(stop.routeId)
    for key, data of @busStops
      @layerGroups[key] = L.layerGroup(data)
    # L.control.layers(@layerGroups).addTo(@map.leafletMap)

  drawStops: (routeId)->
    @map.leafletMap.addLayer @layerGroups[routeId]

  hideStops: (routeId)->
    @map.leafletMap.removeLayer @layerGroups[routeId]

module.exports = BusStop
