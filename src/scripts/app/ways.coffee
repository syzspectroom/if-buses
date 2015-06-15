# _route = gts.monitor.routes.values()[15]; //route
# _i1 = _route.lines.size()-1; //lines  in route
# // _route.lines.get(_i1) //id on _in1 line for current route
# _line = gts.monitor.routes.lines.get(_route.lines.get(_i1)); //get line info by id
#
# _zone = gts.monitor.routes.zones.get(_line.zoneIdEnd); //get last bus stop
#
# _zone = gts.monitor.routes.zones.get(_line.zoneIdStart); //get first bus stop
# // zones coords are used to build routes
class Ways
  constructor: (params)->
    @data = []
    @map = params.map
    @lines = []
    @busStops = params.busStops
    @routes = params.routes

  getLines: (routeId)->
    lines = []
    linesLeft = @data[routeId].length
    while linesLeft--
      points = []
      cLine = @data[routeId][linesLeft]
      #add last busStop to coords
      points.push @busStops.getCordsRouteAndId({routeId: routeId, zoneId: cLine.zoneIdEnd})

      poliesLeft = cLine.latPoints.length
      while poliesLeft--
        points.push [ cLine.latPoints[poliesLeft] / 1000000, cLine.lonPoints[poliesLeft] / 1000000 ]

      #add first busStop to coords
      points.push @busStops.getCordsRouteAndId({routeId: routeId, zoneId: cLine.zoneIdStart})

      lines.push L.polyline points,
        color: @routes.getOutLineColorById(routeId)

    lines

  centerMap: (routeId)->
    @map.leafletMap.fitBounds @lines[routeId].getBounds()

  drawRoute: (routeId)->
    @map.leafletMap.addLayer @lines[routeId]

  hideRoute: (routeId)->
    @map.leafletMap.removeLayer @lines[routeId]

  generateLines: ->
    for routeId, route  of @data
      @lines[routeId] = L.featureGroup @getLines(routeId)

  parseData: (waysData) ->
    for ways in waysData.values
      @data[ways.routeId] ||= []
      @data[ways.routeId].push ways

    @generateLines()

module.exports = Ways
