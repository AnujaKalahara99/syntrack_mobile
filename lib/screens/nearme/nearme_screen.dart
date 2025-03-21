import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'nearby_stops_sheet.dart';

class NearMeScreen extends StatefulWidget {
  const NearMeScreen({super.key});

  @override
  State<NearMeScreen> createState() => _NearMeScreenState();
}

class _NearMeScreenState extends State<NearMeScreen> {
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  StreamSubscription? _busLocationSubscription;
  BitmapDescriptor? _busIcon;

  // Initial camera position (Sri Lanka center)
  static const LatLng _center = LatLng(7.8731, 80.7718);

  @override
  void initState() {
    super.initState();
    _loadBusIcon();
    _setupBusLocationListener();
  }

  @override
  void dispose() {
    _busLocationSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadBusIcon() async {
    _busIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/images/routes.png',
    );
  }

  void _setupBusLocationListener() {
    _busLocationSubscription =
        _database.child('buses').onValue.listen((DatabaseEvent event) {
      print('Database event: ${event.snapshot.value}');
      if (event.snapshot.value != null) {
        final Map<dynamic, dynamic> buses =
            event.snapshot.value as Map<dynamic, dynamic>;

        setState(() {
          _markers.clear(); // Clear existing markers

          buses.forEach((busId, busData) {
            final Map<dynamic, dynamic> bus = busData as Map<dynamic, dynamic>;

            // Add marker for each bus
            _markers.add(
              Marker(
                markerId: MarkerId(busId),
                position: LatLng(
                  bus['latitude'] as double,
                  bus['longitude'] as double,
                ),
                icon: _busIcon ??
                    BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueBlue),
                infoWindow: InfoWindow(
                  title: 'Bus ${bus['number']}',
                  snippet:
                      'Speed: ${bus['speed']} km/h\nNext Stop: ${bus['nextStop']}',
                ),
              ),
            );
          });
        });
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Near Me'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            compassEnabled: true,
          ),
          const NearbyStopsSheet(),
        ],
      ),
    );
  }
}
