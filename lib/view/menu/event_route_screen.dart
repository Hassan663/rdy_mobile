import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class EventRouteScreen extends StatefulWidget {
  final Map<String, dynamic> event;

  const EventRouteScreen({Key? key, required this.event}) : super(key: key);

  @override
  _EventRouteScreenState createState() => _EventRouteScreenState();
}

class _EventRouteScreenState extends State<EventRouteScreen> {
  late GoogleMapController mapController;
  LatLng? _currentPosition;
  LatLng? _eventPosition;
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};
  final String _googleApiKey =
      'AIzaSyA2Z-zDSUYtDKK190MKpFPEJwMrtIqO3TI'; // Replace with your real key

  @override
  void initState() {
    super.initState();
    _eventPosition = LatLng(
      double.parse(widget.event['lat'].toString()),
      double.parse(widget.event['lng'].toString()),
    );
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        _setInitialLocation(const LatLng(38.8977, -77.0365)); // White House
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        _setInitialLocation(const LatLng(38.8977, -77.0365)); // White House
        return;
      }
    }

    _locationData = await location.getLocation();

    // Check if in Washington DC
    if (_isInWashingtonDC(_locationData.latitude!, _locationData.longitude!)) {
      _setInitialLocation(
          LatLng(_locationData.latitude!, _locationData.longitude!));
    } else {
      _setInitialLocation(const LatLng(38.8977, -77.0365)); // White House
    }
  }

  bool _isInWashingtonDC(double latitude, double longitude) {
    const double washingtonLat = 38.8977;
    const double washingtonLng = -77.0365;
    const double radius = 0.1; // Roughly 10 km

    return (latitude - washingtonLat).abs() < radius &&
        (longitude - washingtonLng).abs() < radius;
  }

  Future<void> _setInitialLocation(LatLng position) async {
    _currentPosition = position;

    setState(() {
      _markers.add(Marker(
        markerId: const MarkerId('currentLocation'),
        position: _currentPosition!,
        infoWindow: const InfoWindow(title: 'Your Location'),
      ));

      _markers.add(Marker(
        markerId: const MarkerId('eventLocation'),
        position: _eventPosition!,
        infoWindow: InfoWindow(title: widget.event['name']),
      ));
    });

    await _setPolylines();
    await _moveCameraToBounds();
  }

  Future<void> _setPolylines() async {
    if (_currentPosition == null || _eventPosition == null) return;

    PolylinePoints polylinePoints = PolylinePoints();
    // polylinePoints.setLoggingEnabled(true);

    try {
      PolylineRequest request = PolylineRequest(
        origin: PointLatLng(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
        ),
        destination: PointLatLng(
          _eventPosition!.latitude,
          _eventPosition!.longitude,
        ),
        mode: TravelMode.driving,
      );

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: _googleApiKey,
        request: request,
      );

      if (result.points.isNotEmpty) {
        List<LatLng> polylineCoordinates =
            result.points.map((e) => LatLng(e.latitude, e.longitude)).toList();

        setState(() {
          _polylines.add(Polyline(
            polylineId: const PolylineId('route'),
            points: polylineCoordinates,
            color: Colors.blue,
            width: 5,
          ));
        });

        debugPrint('Polyline drawn with ${polylineCoordinates.length} points');
      } else {
        debugPrint('No polyline points. Status: ${result.status}');
      }
    } catch (e) {
      debugPrint('Error fetching route: $e');
    }
  }

  Future<void> _moveCameraToBounds() async {
    if (_currentPosition == null || _eventPosition == null) return;

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        _currentPosition!.latitude < _eventPosition!.latitude
            ? _currentPosition!.latitude
            : _eventPosition!.latitude,
        _currentPosition!.longitude < _eventPosition!.longitude
            ? _currentPosition!.longitude
            : _eventPosition!.longitude,
      ),
      northeast: LatLng(
        _currentPosition!.latitude > _eventPosition!.latitude
            ? _currentPosition!.latitude
            : _eventPosition!.latitude,
        _currentPosition!.longitude > _eventPosition!.longitude
            ? _currentPosition!.longitude
            : _eventPosition!.longitude,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 500));
    mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 60));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.event['name'] ?? 'Event Route')),
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _currentPosition!,
                zoom: 14.0,
              ),
              markers: _markers,
              polylines: _polylines,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
    );
  }
}
