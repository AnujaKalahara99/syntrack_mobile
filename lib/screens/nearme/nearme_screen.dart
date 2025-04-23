import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'nearby_stops_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../utils/map_style.dart';
import '../../components/bus_stop_marker.dart';
import '../../components/bus_marker.dart';
import '../../data/bus_stop_data.dart';
import '../../models/bus_stop_modal.dart';

class NearMeScreen extends StatefulWidget {
  const NearMeScreen({super.key});

  @override
  State<NearMeScreen> createState() => _NearMeScreenState();
}

class _NearMeScreenState extends State<NearMeScreen> {
  late GoogleMapController _mapController;

  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  StreamSubscription? _busLocationSubscription;

  final Set<Marker> _busMarkers = {};
  final Set<Marker> _busStopMarkers = {};
  BitmapDescriptor? _busIcon;
  BitmapDescriptor? _busStopIcon;

  bool _locationPermissionGranted = false;
  BusStop? _selectedBusStop;

  static const LatLng _center = LatLng(6.797809498387382, 79.89142153473581);
  double _currentZoom = 15.0;
  static const double _minZoomForBuses = 12.0;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    _initializeMarkers();
  }

  @override
  void dispose() {
    _busLocationSubscription?.cancel();
    super.dispose();
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      status = await Permission.location.request();
    }

    if (status.isGranted) {
      setState(() {
        _locationPermissionGranted = true;
      });
    }
  }

  Future<void> _initializeMarkers() async {
    await _loadIcons();
    _setupBusStopMarkers();
    print("##_busStopMarkers: ${_busStopMarkers}");
    _setupBusLocationListener();
  }

  Future<void> _loadIcons() async {
    _busIcon = await BusMarker.getBusIcon();
    _busStopIcon = await BusStopMarker.getBusStopIcon();
  }

  void _setupBusStopMarkers() {
    final busStops = BusStopData.getNearestBusStops();
    setState(() {
      _busStopMarkers.clear();
      for (var busStop in busStops) {
        if (_busStopIcon != null) {
          _busStopMarkers.add(
            BusStopMarker.createMarker(
              busStop,
              _busStopIcon!,
              onTap: () {
                setState(() {
                  _selectedBusStop = busStop;
                });
              },
            ),
          );
        }
      }
    });
  }

  void _setupBusLocationListener() {
    _busLocationSubscription =
        _database.child('buses').onValue.listen((DatabaseEvent event) {
      print("##event.snapshot.value: ${event.snapshot.value}");
      if (event.snapshot.value != null) {
        final Map<dynamic, dynamic> buses =
            event.snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          _busMarkers.clear();
          buses.forEach((busId, busData) {
            final Map<dynamic, dynamic> bus = busData as Map<dynamic, dynamic>;
            if (_busIcon != null) {
              _busMarkers.add(
                BusMarker.createMarker(
                  id: busId,
                  latitude: bus['latitude'] as double,
                  longitude: bus['longitude'] as double,
                  busNumber: bus['number'] as String,
                  nextStop: bus['nextStop'] as String,
                  speed: (bus['speed'] as num).toDouble(),
                  icon: _busIcon!,
                ),
              );
            }
          });
        });
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _currentZoom = position.zoom;
    });
  }

  void _zoomIn() {
    _mapController.animateCamera(
      CameraUpdate.zoomIn(),
    );
  }

  void _zoomOut() {
    _mapController.animateCamera(
      CameraUpdate.zoomOut(),
    );
  }

  Set<Marker> get _visibleMarkers {
    final markers = <Marker>{..._busMarkers};
    if (_currentZoom >= _minZoomForBuses) {
      // markers.addAll(_busMarkers);
      markers.addAll(_busStopMarkers);
    }
    return markers;
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
            onCameraMove: _onCameraMove,
            initialCameraPosition: const CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
            markers: _visibleMarkers,
            myLocationEnabled: _locationPermissionGranted,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            compassEnabled: true,
            style: mapStyle,
          ),
          Positioned(
            right: 5,
            top: 55,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'zoomIn',
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: _zoomIn,
                  child: const Icon(Icons.add, color: Colors.black),
                ),
                FloatingActionButton(
                  heroTag: 'zoomOut',
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: _zoomOut,
                  child: const Icon(Icons.remove, color: Colors.black),
                ),
              ],
            ),
          ),
          NearbyStopsSheet(selectedBusStop: _selectedBusStop),
        ],
      ),
    );
  }
}
