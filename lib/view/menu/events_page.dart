import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/controller/menu/events_controller.dart';
import 'package:ryd4ride/routing/app_routes.dart';
import 'package:ryd4ride/view/menu/event_route_screen.dart';
import 'package:ryd4ride/widgets/common_appbar.dart';
import 'package:ryd4ride/widgets/common_bottomsheet.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'RDY4RIDE',
        onLeadingPressed: () {
          MenuBottomSheet.showMenu(context);
        },
        onTrailingPressed: () {
          Get.toNamed(AppRoutes.notifications);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(Icons.map),
        onPressed: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GetBuilder<EventsController>(
            init: EventsController(),
            builder: (controller) {
              return RefreshIndicator(
                onRefresh: () async {
                  await controller.refreshEvents();
                },
                child: controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : controller.eventData.isEmpty
                        ? _buildEmptyState(controller)
                        : AnimationLimiter(
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: controller.eventData.length,
                              itemBuilder: (context, index) {
                                var event = controller.eventData[index];

                                // Get card color directly from crowd_status
                                Color cardColor = _getCrowdStatusCardColor(
                                    event["crowd_status"]);

                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 500),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(
                                              EventRouteScreen(event: event));
                                        },
                                        child: Card(
                                          elevation: 3,
                                          margin:
                                              const EdgeInsets.only(bottom: 16),
                                          color: cardColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  event["name"]?.toString() ??
                                                      "Unknown Event",
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  event["address"]
                                                          ?.toString() ??
                                                      event["location"]
                                                          ?.toString() ??
                                                      "Unknown Location",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black87,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 12),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    // Crowd info
                                                    Expanded(
                                                      child: InfoWidget(
                                                        icon: Icons.people,
                                                        text:
                                                            "${event["crowd"] ?? 0}+ Crowd",
                                                        iconColor:
                                                            _getCrowdStatusColor(
                                                                event[
                                                                    "crowd_status"]),
                                                      ),
                                                    ),

                                                    // Distance info
                                                    Expanded(
                                                      child: InfoWidget(
                                                        icon: Icons.navigation,
                                                        text: event["distanceFormatted"]
                                                                ?.toString() ??
                                                            event["distance"]
                                                                ?.toString() ??
                                                            "Unknown",
                                                      ),
                                                    ),

                                                    // Time info
                                                    Expanded(
                                                      child: InfoWidget(
                                                        icon: Icons.access_time,
                                                        text: _formatEventTime(
                                                            event),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 16),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      // Navigate to RouteScreen with the selected event
                                                      _navigateToRouteScreen(
                                                          event);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                              0xFF14365D),
                                                      foregroundColor:
                                                          Colors.white,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 12),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                    child:
                                                        const Text("Get Route"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(EventsController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.event_busy, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            "No events available",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Pull down to refresh",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: controller.refreshEvents,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF14365D),
              foregroundColor: Colors.white,
            ),
            child: const Text("Refresh Now"),
          ),
        ],
      ),
    );
  }

  // Get appropriate color based on crowd status for the text/icon
  Color _getCrowdStatusColor(String? status) {
    return switch (status?.toLowerCase() ?? 'green') {
      'yellow' => Colors.amber,
      'red' => Colors.red,
      _ => Colors.green,
    };
  }

  // Get appropriate color for the card background based on status
  Color _getCrowdStatusCardColor(String? status) {
    return switch (status?.toLowerCase() ?? 'green') {
      'yellow' => Colors.yellow.shade200,
      'red' => Colors.red.shade100,
      _ => Colors.green.shade200,
    };
  }

  // Format event time for display
  String _formatEventTime(Map<String, dynamic> event) {
    if (event["start_time"] != null) {
      return event["start_time"].toString();
    }

    if (event["time"] != null) {
      return event["time"].toString();
    }

    try {
      if (event["start_date"] != null) {
        final DateTime date =
            DateTime.parse(event["start_date"].toString()).toLocal();
        final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
        final minute = date.minute.toString().padLeft(2, '0');
        final period = date.hour < 12 ? 'AM' : 'PM';
        return '$hour:$minute $period';
      }
    } catch (e) {
      debugPrint("Error formatting time: $e");
    }

    return "Unknown";
  }

  // Navigate to RouteScreen with selected event
  void _navigateToRouteScreen(Map<String, dynamic> event) {
    try {
      // Validate location data
      final double lat = double.tryParse(event["lat"]?.toString() ?? "0") ?? 0;
      final double lng = double.tryParse(event["lng"]?.toString() ?? "0") ?? 0;

      if (lat == 0 || lng == 0) {
        Get.snackbar("Error", "Invalid event location");
        return;
      }

      // Navigate to RouteScreen with the event data
      Get.to(EventRouteScreen(event: event));
    } catch (e) {
      debugPrint("Error navigating to route screen: $e");
      Get.snackbar("Error", "Failed to navigate to route screen");
    }
  }
}

class InfoWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? iconColor;

  const InfoWidget({
    Key? key,
    required this.icon,
    required this.text,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor ?? AppColors.primaryColor),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.blackButtoncolor,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
