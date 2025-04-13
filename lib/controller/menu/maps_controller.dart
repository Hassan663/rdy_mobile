
import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart'
    hide TextDirection; // Hide Flutter's TextDirection
import 'package:flutter/material.dart' as material
    show TextDirection; // Import Flutter's TextDirection with alias
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ryd4ride/services/apis/apis_services.dart';
import 'package:ryd4ride/services/location_service.dart';
import 'package:ryd4ride/view/menu/event_route_screen.dart';
import 'package:ryd4ride/view/menu/maps_screen.dart';

class MapsController extends GetxController {
  LatLng currentPosition = const LatLng(38.9072, -77.0369);
  LatLng lastApiCallPosition = const LatLng(38.9072, -77.0369);
  Set<Marker> markers = <Marker>{};
  Map<String, dynamic>? selectedEvent;
  bool isLoading = false;

  GoogleMapController? googleMapController;
  List<dynamic> eventData = [];
  Timer? _debounce;

  final whiteHouseLocation = const LatLng(38.8977, -77.0365);
  final int radiusThreshold = 30; // 30km radius threshold

  @override
  void onInit() {
    super.onInit();
    determineInitialLocation();
  }

  Future<void> determineInitialLocation() async {
    isLoading = true;
    update();

    final location = await LocationService().getCurrentLocation();
    LatLng finalPosition = whiteHouseLocation;

    if (location != null) {
      final userLat = location.latitude;
      final userLng = location.longitude;

      if ((userLat >= 38.80 && userLat <= 39.00) &&
          (userLng >= -77.15 && userLng <= -76.90)) {
        finalPosition = LatLng(userLat, userLng);
      }
    }

    currentPosition = finalPosition;
    lastApiCallPosition = finalPosition;
    await fetchEvents(finalPosition);

    isLoading = false;
    update();
  }

  // Calculate distance between two coordinates in kilometers
  double calculateDistance(LatLng pos1, LatLng pos2) {
    const double earthRadius = 6371; // Earth's radius in km
    final double lat1 = pos1.latitude * (pi / 180);
    final double lat2 = pos2.latitude * (pi / 180);
    final double dLat = (pos2.latitude - pos1.latitude) * (pi / 180);
    final double dLng = (pos2.longitude - pos1.longitude) * (pi / 180);

    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLng / 2) * sin(dLng / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  // Format distance to 1 decimal place
  String formatDistance(double distance) {
    return '${distance.toStringAsFixed(1)}km';
  }

  // Format event time from ISO string
  Map<String, String> formatEventTime(String? startDate, String? endDate) {
    String startTime = '10:30 AM';
    String endTime = '12:30 PM';

    try {
      if (startDate != null) {
        final DateTime start = DateTime.parse(startDate).toLocal();
        // Manual time formatting to avoid intl package issues
        final hour = start.hour % 12 == 0 ? 12 : start.hour % 12;
        final minute = start.minute.toString().padLeft(2, '0');
        final period = start.hour < 12 ? 'AM' : 'PM';
        startTime = '$hour:$minute $period';
      }

      if (endDate != null) {
        final DateTime end = DateTime.parse(endDate).toLocal();
        // Manual time formatting
        final hour = end.hour % 12 == 0 ? 12 : end.hour % 12;
        final minute = end.minute.toString().padLeft(2, '0');
        final period = end.hour < 12 ? 'AM' : 'PM';
        endTime = '$hour:$minute $period';
      }
    } catch (e) {
      print("Error formatting date: $e");
    }

    return {
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  void onMapMoved(CameraPosition position) {
    currentPosition = position.target;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () {
      // Check if the distance exceeds threshold before calling API
      double distance = calculateDistance(lastApiCallPosition, position.target);
      if (distance > radiusThreshold) {
        fetchEvents(position.target);
        lastApiCallPosition = position.target;
      }
    });
  }

  Future<void> fetchEvents(LatLng pos) async {
    isLoading = true;
    update();

    try {
      final response =
          await Get.find<ApiService>().getRequest("api/events", params: {
        "lat": pos.latitude.toString(),
        "lng": pos.longitude.toString(),
        "radius": "50",
      });

      final List<dynamic> events =
          (response["data"]?["data"]?["events"] as List?) ?? [];

      eventData = events;
      await loadMarkers();
    } catch (e) {
      print("Error fetching events: $e");
      eventData = [];
      markers = {};
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> loadMarkers() async {
    final Set<Marker> loadedMarkers = {};

    for (var event in eventData) {
      try {
        final double lat = double.tryParse(event["lat"].toString()) ?? 0;
        final double lng = double.tryParse(event["lng"].toString()) ?? 0;
        if (lat == 0 || lng == 0) continue;

        final LatLng eventLatLng = LatLng(lat, lng);
        final String crowdStatus = event["crowd_status"] ?? "green";

        Color markerColor = switch (crowdStatus.toLowerCase()) {
          "yellow" => Colors.yellow,
          "red" => Colors.red,
          _ => Colors.green,
        };

        final icon = await createCustomMarkerBitmap(Icons.traffic, markerColor);

        // Calculate and add distance to the event data
        double distance = calculateDistance(currentPosition, eventLatLng);
        event['distance'] = distance;

        loadedMarkers.add(Marker(
          markerId: MarkerId(event["id"].toString()),
          position: eventLatLng,
          icon: icon,
          onTap: () {
            selectedEvent = event;
            showEventBottomSheet();
            update();
          },
        ));
      } catch (_) {}
    }

    loadedMarkers.add(Marker(
      markerId: const MarkerId("user"),
      position: currentPosition,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      onTap: () {
        selectedEvent = null;
        update();
      },
    ));

    markers = loadedMarkers;
    update();
  }

  Future<BitmapDescriptor> createCustomMarkerBitmap(
      IconData iconData, Color color) async {
    const double size = 150;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..color = Colors.transparent;

    canvas.drawRect(Rect.fromLTWH(0, 0, size, size), paint);

    // Use Flutter's TextDirection explicitly with the material alias
    final textPainter = TextPainter(textDirection: material.TextDirection.ltr);
    textPainter.text = TextSpan(
      text: String.fromCharCode(iconData.codePoint),
      style: TextStyle(
        fontSize: size * 0.6,
        fontFamily: iconData.fontFamily,
        package: iconData.fontPackage,
        color: color,
      ),
    );
    textPainter.layout(minWidth: 0, maxWidth: size);
    textPainter.paint(
        canvas,
        Offset(
            (size - textPainter.width) / 2, (size - textPainter.height) / 2));

    final img =
        await recorder.endRecording().toImage(size.toInt(), size.toInt());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  void showEventBottomSheet() {
    if (selectedEvent != null) {
      // Process the event data for display
      final Map<String, dynamic> processedEvent = Map.from(selectedEvent!);

      // Format the distance
      if (processedEvent['distance'] != null) {
        processedEvent['distanceFormatted'] =
            formatDistance(processedEvent['distance']);
      }

      // Format the time
      final times = formatEventTime(
          processedEvent['start_date'], processedEvent['end_date']);
      processedEvent['start_time'] = times['startTime'];
      processedEvent['end_time'] = times['endTime'];

      // Format crowd data
      final int crowd = processedEvent['crowd'] ?? 0;
      processedEvent['crowd_size'] =
          crowd > 0 ? '$crowd+ Crowd' : 'Unknown Crowd';

      Get.bottomSheet(
        EventDetailsSheet(
          event: processedEvent,
          onGetRoutePressed: () {
            Get.back(); // Close the bottom sheet
            Get.to(() => EventRouteScreen(event: processedEvent));
          },
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
      );
    }
  }
}
