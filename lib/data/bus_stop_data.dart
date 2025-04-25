import '../models/bus_stop_modal.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusStopData {
  static final busStopList = <BusStop>[
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
    BusStop(
      id: 'BS004',
      name: 'Prince of Wales',
      location: 'Moratuwa',
      estimatedArrival: DateTime.now(),
      nextBus: '100',
      latitude: 6.7861386,
      longitude: 79.8845261,
      routes: ['100', '101', '60', '32', '42', '26', '02', '17'],
    ),
    BusStop(
      id: 'BS005',
      name: 'Rawathawatta',
      location: 'Moratuwa',
      estimatedArrival: DateTime.now(),
      nextBus: '101',
      latitude: 6.789940690223165,
      longitude: 79.88583474317664,
      routes: ['100', '101', '60', '32', '42', '26', '02', '17'],
    ),
    BusStop(
      id: 'BS006',
      name: 'Mendis Lane',
      location: 'Moratuwa',
      estimatedArrival: DateTime.now(),
      nextBus: '60',
      latitude: 6.7824737,
      longitude: 79.8841963,
      routes: ['60', '32', '42', '26', '02', '17'],
    ),
    BusStop(
      id: 'BS007',
      name: 'C. P. De Silva Mawatha',
      location: 'Moratuwa',
      estimatedArrival: DateTime.now(),
      nextBus: '100',
      latitude: 6.8078929,
      longitude: 79.8839146,
      routes: ['100', '101'],
    ),
    BusStop(
      id: 'BS008',
      name: 'Moratuwa Bus Stop',
      location: 'Moratuwa',
      estimatedArrival: DateTime.now(),
      nextBus: '101',
      latitude: 6.7745,
      longitude: 79.8825,
      routes: ['100', '101', '60', '32', '42', '26', '02', '17'],
    ),
    BusStop(
      id: 'BS009',
      name: 'Kospalana Bridge',
      location: 'Piliyandala',
      estimatedArrival: DateTime.now(),
      nextBus: '255',
      latitude: 6.7950398414424695,
      longitude: 79.90544962360272,
      routes: ['255', '158'],
    ),
    BusStop(
      id: 'BS010',
      name: 'Deniya',
      location: 'Piliyandala',
      estimatedArrival: DateTime.now(),
      nextBus: '255',
      latitude: 6.796070848321252,
      longitude: 79.9085166058553,
      routes: ['255', '158'],
    ),
    BusStop(
      id: 'BS011',
      name: 'Suwarapola',
      location: 'Piliyandala',
      estimatedArrival: DateTime.now(),
      nextBus: '255',
      latitude: 6.7993640115741165,
      longitude: 79.91678741829249,
      routes: ['255', '158'],
    ),
  ];
  static List<BusStop> getAllBusStops() {
    return busStopList;
  }

  static List<BusStop> getNearestBusStops() {
    return busStopList.take(2).toList();
  }

  static List<String> getRecentSearches() {
    return [
      'Kokis Kade - Ganemulla',
      'Gampaha Bus Stand',
    ];
  }

  static List<LatLng> getRoutePath(String routeNumber) {
    // This is sample data - in a real app, this would come from a database or API
    switch (routeNumber) {
      case '255':
        return [
          const LatLng(6.795021173969844, 79.9004152106318), // Moratuwa Campus
          const LatLng(6.797290248803679, 79.88836617074674), // Katubadda
          const LatLng(6.803499869618562, 79.88745546245471), // Angulana
        ];
      case '100':
        return [
          const LatLng(6.797290248803679, 79.88836617074674), // Katubadda
          const LatLng(6.803499869618562, 79.88745546245471), // Angulana
          const LatLng(6.795021173969844, 79.9004152106318), // Moratuwa Campus
        ];
      default:
        return [];
    }
  }
}
