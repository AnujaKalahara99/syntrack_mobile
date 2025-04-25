class Route {
  final String number;
  final String name;
  final List<String> busStopIds;
  final String startLocation;
  final String endLocation;
  final double estimatedDuration; // in minutes
  final double estimatedDistance; // in kilometers
  final bool isActive;
  final List<String> operatingHours; // e.g., ["06:00-22:00"]
  final double fare; // in LKR

  Route({
    required this.number,
    required this.name,
    required this.busStopIds,
    required this.startLocation,
    required this.endLocation,
    required this.estimatedDuration,
    required this.estimatedDistance,
    this.isActive = true,
    required this.operatingHours,
    required this.fare,
  });
}
