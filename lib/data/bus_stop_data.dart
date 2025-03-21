import '../models/bus_stop_modal.dart';

class BusStopData {
  static List<BusStop> getNearestBusStops() {
    return [
      BusStop(
        name: 'Hunu Poranuwa',
        location: 'Gampaha',
        estimatedArrival: DateTime.now(),
        nextBus: '205',
      ),
      BusStop(
        name: 'Kokis Kade',
        location: 'Ganemulla',
        estimatedArrival: DateTime.now(),
        nextBus: '123',
      ),
    ];
  }

  static List<String> getRecentSearches() {
    return [
      'Kokis Kade - Ganemulla',
    ];
  }
}
