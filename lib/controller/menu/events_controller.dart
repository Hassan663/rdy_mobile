// import 'dart:math';

// import 'package:ryd4ride/constants/libraries/app_libraries.dart';

// class EventsController extends GetxController {
//   bool isLoading = true;

//   var locations = [
//     {
//       "title": "9023 Whilshire",
//       "subtitle": "Beverly Hills, 90211",
//       "distance": "2.3km",
//       "time": "10:30AM - 12:30PM",
//       "crowd": "200+ "
//     },
//     {
//       "title": "9023 Whilshire",
//       "subtitle": "Beverly Hills, 90211",
//       "distance": "2.3km",
//       "time": "10:30 AM - 12:30 PM",
//       "crowd": "500+ "
//     },
//     {
//       "title": "9023 Whilshire",
//       "subtitle": "Beverly Hills, 90211",
//       "distance": "2.3km",
//       "time": "10:30 AM - 12:30 PM",
//       "crowd": "1200+ "
//     },
//   ].obs;

//   var eventData = [
//     {
//       "name": "Washington Wizards vs. Los Angeles Lakers",
//       "date": "2025-01-30",
//       "time": "07:00 PM",
//       "distance": "2.3km",
//       "location": "Capital One Arena, Washington, DC",
//       "lat": 38.8981,
//       "lng": -77.0209,
//       "crowd": Random().nextInt(1300 - 100 + 1) + 100, // Random crowd size
//     },
//     {
//       "name": "Washington Nationals vs. Los Angeles Dodgers",
//       "date": "2025-04-07",
//       "time": "06:45 PM",
//       "location": "Nationals Park, Washington, DC",
//       "lat": 38.873,
//       "lng": -77.0075,
//       "distance": "2.3km",
//       "crowd": Random().nextInt(1300 - 100 + 1) + 100, // Random crowd size
//     },
//     {
//       "name": "Washington Wizards vs. San Antonio Spurs",
//       "date": "2025-02-10",
//       "time": "07:00 PM",
//       "distance": "2.3km",
//       "location": "Capital One Arena, Washington, DC",
//       "lat": 38.8729 ,
//       "lng": -77.0074,
//       "crowd":Random().nextInt(1300 - 100 + 1) + 100, // Random crowd size
//     },
//     {
//       "name": "Washington Nationals vs. Los Angeles Dodgers",
//       "date": "2025-04-08",
//       "time": "06:45 PM",
//       "distance": "2.3km",
//       "location": "Nationals Park, Washington, DC",
//       "lat": 38.8991,
//       "lng":  -77.0225,
//       "crowd": Random().nextInt(1300 - 100 + 1) + 100, // Random crowd size
//     },
//     {
//       "name": "Washington Wizards vs. Brooklyn Nets",
//       "date": "2025-03-29",
//       "time": "07:00 PM",
//       "distance": "2.3km",
//       "location": "Capital One Arena, Washington, DC",
//       "lat": 38.8735,
//       "lng":-77.0060,
//       "crowd": Random().nextInt(1300 - 100 + 1) + 100, // Random crowd size
//     },
//     {
//       "name": "Washington Wizards vs. Utah Jazz",
//       "date": "2025-03-05",
//       "time": "07:00 PM",
//       "location": "Capital One Arena, Washington, DC",
//       "lat":  38.8970,
//       "distance": "2.3km",
//       "lng": -77.0190,
//       "crowd": Random().nextInt(1300 - 100 + 1) + 100, // Random crowd size
//     },
//     {
//       "name": "Washington Wizards vs. Orlando Magic",
//       "date": "2025-04-03",
//       "time": "07:00 PM",
//       "distance": "2.3km",
//       "location": "Capital One Arena, Washington, DC",
//       "lat": 38.8999,
//       "lng": -77.0210,
//       "crowd": Random().nextInt(1300 - 100 + 1) + 100, // Random crowd size
//     },
//   ].obs;
//   @override
//   void onReady() {
//     isLoading = false;
//     update();
//     super.onReady();
//   }
// }
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ryd4ride/services/apis/apis_services.dart';
import 'package:ryd4ride/controller/menu/maps_controller.dart';

class EventsController extends GetxController {
  RxList<Map<String, dynamic>> eventData = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;

  late MapsController mapsController;

  @override
  void onInit() {
    super.onInit();
    // Get reference to MapsController
    mapsController = Get.find<MapsController>();
    // Load events initially
    fetchEvents();
  }

  Future<void> refreshEvents() async {
    return fetchEvents();
  }

  Future<void> fetchEvents() async {
    isLoading.value = true;
    update();

    try {
      // Get current position from MapsController to calculate distances
      final currentPosition = mapsController.currentPosition;

      final response =
          await Get.find<ApiService>().getRequest("api/events", params: {
        "lat": currentPosition.latitude.toString(),
        "lng": currentPosition.longitude.toString(),
        "radius": "50",
      });

      final List<dynamic> events =
          (response["data"]?["data"]?["events"] as List?) ?? [];

      // Process events to add formatted values
      final List<Map<String, dynamic>> processedEvents = [];

      for (var event in events) {
        if (event is Map<String, dynamic>) {
          final Map<String, dynamic> processedEvent =
              Map<String, dynamic>.from(event);

          // Calculate distance if coordinates are available
          try {
            final double lat = double.tryParse(event["lat"].toString()) ?? 0;
            final double lng = double.tryParse(event["lng"].toString()) ?? 0;

            if (lat != 0 && lng != 0) {
              final distance = mapsController.calculateDistance(
                  currentPosition, LatLng(lat, lng));
              processedEvent['distance'] = distance;
              processedEvent['distanceFormatted'] =
                  '${distance.toStringAsFixed(1)}km';
            }
          } catch (e) {
            print("Error calculating distance: $e");
          }

          // Format times if available
          try {
            if (processedEvent['start_date'] != null) {
              final DateTime start =
                  DateTime.parse(processedEvent['start_date'].toString())
                      .toLocal();
              // Format time
              final hour = start.hour % 12 == 0 ? 12 : start.hour % 12;
              final minute = start.minute.toString().padLeft(2, '0');
              final period = start.hour < 12 ? 'AM' : 'PM';
              processedEvent['start_time'] = '$hour:$minute $period';
            }

            if (processedEvent['end_date'] != null) {
              final DateTime end =
                  DateTime.parse(processedEvent['end_date'].toString())
                      .toLocal();
              // Format time
              final hour = end.hour % 12 == 0 ? 12 : end.hour % 12;
              final minute = end.minute.toString().padLeft(2, '0');
              final period = end.hour < 12 ? 'AM' : 'PM';
              processedEvent['end_time'] = '$hour:$minute $period';
            }
          } catch (e) {
            print("Error formatting times: $e");
          }

          processedEvents.add(processedEvent);
        }
      }

      eventData.value = processedEvents;
    } catch (e) {
      print("Error fetching events: $e");
      eventData.value = [];
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
