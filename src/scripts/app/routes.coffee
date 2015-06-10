class Routes
  constructor: ->
    @data = []

  getById: (id) ->
    @data[id]

  getNameById: (id) ->
    @getById(id).name

  getFillColorById: (id)->
    rgba2hex @getById(id).fillColor

  getOutLineColorById: (id)->
    rgba2hex @getById(id).outLineColor

  parseData: (routesInfo) ->
    for route in routesInfo.values
      @data[route.id] =
        name: route.name
        shortName: route.shortName
        fillColor: route.fillColor
        outLineColor: route.outLineColor
        distance: route.distance

module.exports = Routes

 
rgba2hex = (rgba) ->
  colors = rgba.split(',')
  componentToHex = (c) ->
    hex = parseInt(c).toString(16)
    if hex.length == 1 then '0' + hex else hex

  '#' + componentToHex(colors[0]) + componentToHex(colors[1]) + componentToHex(colors[2])
