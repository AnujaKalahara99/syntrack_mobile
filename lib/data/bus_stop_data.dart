import '../models/bus_stop_modal.dart';

class BusStopData {
  static List<BusStop> getNearestBusStops() {
    return [
      BusStop(
        id: 'BS001',
        name: 'Moratuwa Campus',
        location: 'Moratuwa',
        estimatedArrival: DateTime.now(),
        nextBus: '255',
        latitude: 6.795021173969844,
        longitude: 79.9004152106318,
        routes: ['255', '123', '100'],
      ),
      BusStop(
        id: 'BS002',
        name: 'Katubadda',
        location: 'Moratuwa',
        estimatedArrival: DateTime.now(),
        nextBus: '100',
        latitude: 6.797290248803679,
        longitude: 79.88836617074674,
        routes: ['100', '101', '400'],
      ),
      BusStop(
        id: 'BS003',
        name: 'Angulana',
        location: 'Moratuwa',
        estimatedArrival: DateTime.now(),
        nextBus: '101',
        latitude: 6.803499869618562,
        longitude: 79.88745546245471,
        routes: ['100', '101', '400'],
      ),
    ];
  }

  static List<String> getRecentSearches() {
    return [
      'Kokis Kade - Ganemulla',
      'Gampaha Bus Stand',
    ];
  }
}
