import '../models/route_modal.dart';

class RouteData {
  static final routeList = <Route>[
    Route(
      number: '255',
      name: 'Moratuwa - Colombo',
      busStopIds: ['BS001', 'BS002', 'BS003', 'BS008'],
      startLocation: 'Moratuwa Campus',
      endLocation: 'Colombo Fort',
      estimatedDuration: 45.0,
      estimatedDistance: 15.5,
      operatingHours: ['05:30-22:00'],
      fare: 50.0,
    ),
    Route(
      number: '100',
      name: 'Moratuwa - Pettah',
      busStopIds: [
        'BS002',
        'BS003',
        'BS004',
        'BS005',
        'BS006',
        'BS007',
        'BS008'
      ],
      startLocation: 'Katubadda',
      endLocation: 'Pettah',
      estimatedDuration: 60.0,
      estimatedDistance: 18.0,
      operatingHours: ['05:00-23:00'],
      fare: 45.0,
    ),
    Route(
      number: '101',
      name: 'Moratuwa - Fort',
      busStopIds: ['BS003', 'BS004', 'BS005', 'BS007', 'BS008'],
      startLocation: 'Angulana',
      endLocation: 'Fort',
      estimatedDuration: 55.0,
      estimatedDistance: 17.0,
      operatingHours: ['05:30-22:30'],
      fare: 48.0,
    ),
  ];

  static List<Route> getAllRoutes() {
    return routeList;
  }

  static Route? getRouteByNumber(String number) {
    try {
      return routeList.firstWhere((route) => route.number == number);
    } catch (e) {
      return null;
    }
  }

  static List<Route> getRoutesByBusStop(String busStopId) {
    return routeList
        .where((route) => route.busStopIds.contains(busStopId))
        .toList();
  }

  static List<Route> getActiveRoutes() {
    return routeList.where((route) => route.isActive).toList();
  }
}
