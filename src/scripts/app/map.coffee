class Map
  constructor: (container = 'map') ->
    @leafletMap = L.map(container).setView([
      48.920967
      24.710520
    ], 13)

    L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>'
      maxZoom: 18).addTo @leafletMap

module.exports = Map
