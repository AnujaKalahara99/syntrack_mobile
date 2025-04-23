class BusStop {
  final String name;
  final String location;
  final DateTime estimatedArrival;
  final String nextBus;
  final double latitude;
  final double longitude;
  final String id;
  final List<String> routes;

  const BusStop({
    required this.name,
    required this.location,
    required this.estimatedArrival,
    required this.nextBus,
    required this.latitude,
    required this.longitude,
    required this.id,
    required this.routes,
  });
}
