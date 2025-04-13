import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ryd4ride/controller/menu/maps_controller.dart';
import 'package:ryd4ride/view/menu/events_page.dart';
import 'package:ryd4ride/widgets/common_appBar.dart';
import 'package:ryd4ride/routing/app_routes.dart';
import 'package:ryd4ride/widgets/common_bottomsheet.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapsController>(
      init: MapsController(),
      builder: (controller) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 4,
            onPressed: () {
              Get.to(() => const EventsScreen());
            },
            shape: const CircleBorder(),
            child: const Icon(
              Icons.list,
              color: Colors.black,
            ),
          ),
          appBar: CommonAppBar(
            title: 'RDY4RIDE',
            onLeadingPressed: () => MenuBottomSheet.showMenu(context),
            onTrailingPressed: () => Get.toNamed(AppRoutes.notifications),
          ),
          body: Stack(
            children: [
              GoogleMap(
                myLocationEnabled:
                    true, // ✅ Shows the user's location on the map
                myLocationButtonEnabled: false, // ❌ Hides the location icon
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: controller.currentPosition,
                  zoom: 13,
                ),
                markers: controller.markers,
                onMapCreated: (mapController) {
                  controller.googleMapController = mapController;
                },
                onCameraMove: (position) {
                  controller.onMapMoved(position);
                },
              ),
              if (controller.isLoading)
                const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                ),
            ],
          ),
        );
      },
    );
  }
}

class EventDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> event;
  final VoidCallback onGetRoutePressed;

  const EventDetailsSheet({
    super.key,
    required this.event,
    required this.onGetRoutePressed,
  });

  @override
  Widget build(BuildContext context) {
    // Extract event details with fallbacks
    final String eventTitle = event['name'] ?? 'Event';
    final String eventLocation = event['address'] ?? 'Unknown Location';

    // Use formatted distance or fallback
    final String distance = event['distanceFormatted'] ?? '-.--km';

    // Use formatted crowd or fallback
    final String crowd = event['crowd_size'] ?? 'Unknown Crowd';

    // Use formatted time or fallback
    final String startTime = event['start_time'] ?? '10:30 AM';
    final String endTime = event['end_time'] ?? '12:30 PM';

    // Use crowd status for color
    final String crowdStatus = event['crowd_status'] ?? 'green';
    final Color crowdColor = switch (crowdStatus.toLowerCase()) {
      'yellow' => Colors.amber,
      'red' => Colors.red,
      _ => Colors.green,
    };

    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event title and location
            Text(
              eventTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.grey, size: 16),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    eventLocation,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // First row: Crowd and Distance
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Crowd indicator
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.people, color: crowdColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          crowd,
                          style: const TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                // Distance indicator
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.directions, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        distance,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Second row: Time
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  '$startTime - $endTime',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Get Route button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onGetRoutePressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF14365D),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Get Route',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
