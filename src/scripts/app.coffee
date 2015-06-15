logger = require('./test/my')
Map = require('./app/map')
routesData = require('./app/routes_data')
Routes = require('./app/routes')

busStopsData = require('./app/bus_stops_data')
BusStops = require('./app/bus_stops')

waysData = require('./app/ways_data')
Ways = require('./app/ways')
Ui = require('./app/ui')

logger('hello browserify!!')

map = new Map()

routes = new Routes()
routes.parseData routesData

busStops = new BusStops
  map: map
  routes: routes
busStops.parseData busStopsData

ways = new Ways
  map: map
  busStops: busStops
  routes: routes

ways.parseData waysData

ui = new Ui
  containerId: 'controls'
  routes: routes
  ways: ways
  busStops: busStops
