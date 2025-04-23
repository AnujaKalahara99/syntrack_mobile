import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/bus_stop_modal.dart';

class BusStopMarker {
  static Future<BitmapDescriptor> getBusStopIcon() async {
    return await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(30, 30)),
      'assets/images/bus_stop.png',
    );
  }

  static Marker createMarker(
    BusStop busStop,
    BitmapDescriptor icon, {
    VoidCallback? onTap,
  }) {
    return Marker(
      markerId: MarkerId(busStop.id),
      position: LatLng(busStop.latitude, busStop.longitude),
      icon: icon,
      infoWindow: InfoWindow(
        title: busStop.name,
        snippet:
            'Routes: ${busStop.routes.join(', ')}\nNext Bus: ${busStop.nextBus}',
        onTap: onTap,
      ),
      onTap: onTap,
    );
  }
}
