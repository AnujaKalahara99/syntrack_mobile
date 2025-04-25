import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
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
  final Set<Polyline> _routePolylines = {};
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
    _setupBusLocationListener();
  }

  Future<void> _loadIcons() async {
    _busIcon = await BusMarker.getBusIcon();
    _busStopIcon = await BusStopMarker.getBusStopIcon();
  }

  void _setupBusStopMarkers() {
    final busStops = BusStopData.getAllBusStops();
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

  Future<List<LatLng>> _getDirections(List<LatLng> waypoints) async {
    if (waypoints.length < 2) return waypoints;

    final List<LatLng> polylineCoordinates = [];

    // Get directions between consecutive waypoints
    for (int i = 0; i < waypoints.length - 1; i++) {
      final origin = waypoints[i];
      final destination = waypoints[i + 1];

      final String baseUrl =
          'https://maps.googleapis.com/maps/api/directions/json';
      final String apiKey =
          'AIzaSyBEGJuAAI_iCpkbxUedtsoMxorRpQjfrrw'; // Your API key from AndroidManifest.xml

      final response = await http.get(
          Uri.parse('$baseUrl?origin=${origin.latitude},${origin.longitude}'
              '&destination=${destination.latitude},${destination.longitude}'
              '&mode=driving'
              '&key=$apiKey'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          final points = data['routes'][0]['overview_polyline']['points'];
          polylineCoordinates.addAll(_decodePolyline(points));
        }
      }
    }

    return polylineCoordinates;
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      double latitude = lat / 1E5;
      double longitude = lng / 1E5;
      poly.add(LatLng(latitude, longitude));
    }

    return poly;
  }

  void _handleRouteSelected(String route) async {
    setState(() {
      _routePolylines.clear();
    });

    final path = BusStopData.getRoutePath(route);
    if (path.isNotEmpty) {
      final roadAlignedPath = await _getDirections(path);

      setState(() {
        _routePolylines.add(
          Polyline(
            polylineId: PolylineId(route),
            points: roadAlignedPath,
            color: Colors.blue,
            width: 5,
          ),
        );

        // Fit the map to show the entire route
        _mapController.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: LatLng(
                roadAlignedPath.map((p) => p.latitude).reduce(min),
                roadAlignedPath.map((p) => p.longitude).reduce(min),
              ),
              northeast: LatLng(
                roadAlignedPath.map((p) => p.latitude).reduce(max),
                roadAlignedPath.map((p) => p.longitude).reduce(max),
              ),
            ),
            50.0, // padding
          ),
        );
      });
    }
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
            polylines: _routePolylines,
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
          NearbyStopsSheet(
            selectedBusStop: _selectedBusStop,
            onRouteSelected: _handleRouteSelected,
          ),
        ],
      ),
    );
  }
}
