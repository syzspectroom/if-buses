logger = require('./test/my')
Map = require('./app/map')
routesData = require('./app/routes_data')
Routes = require('./app/routes')
busStopsData = require('./app/bus_stops_data')
BusStops = require('./app/bus_stops')

logger('hello browserify!!')

map = new Map()
routes = new Routes()
routes.parseData routesData
console.log routes
busStops = new BusStops
  map: map
  routes: routes

busStops.parseData busStopsData
