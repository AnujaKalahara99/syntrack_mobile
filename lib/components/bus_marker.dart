import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusMarker {
  static Future<BitmapDescriptor> getBusIcon() async {
    return await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/images/routes.png',
    );
  }

  static Marker createMarker({
    required String id,
    required double latitude,
    required double longitude,
    required String busNumber,
    required String nextStop,
    required double speed,
    required BitmapDescriptor icon,
  }) {
    return Marker(
      markerId: MarkerId(id),
      position: LatLng(latitude, longitude),
      icon: icon,
      infoWindow: InfoWindow(
        title: 'Bus $busNumber',
        snippet:
            'Speed: ${speed.toStringAsFixed(1)} km/h\nNext Stop: $nextStop',
        onTap: () {
          // Handle marker tap
        },
      ),
    );
  }
}
