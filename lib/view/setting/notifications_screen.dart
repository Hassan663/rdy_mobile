import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/controller/setting/notifications_controller.dart';

class NotificationScreen extends StatelessWidget {
  

  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: GetBuilder<NotificationController>(
          init:NotificationController(),
          builder: (_) {
            return Column(
              children: [
                // Header with Back Arrow and Title
                Container(
                  padding: const EdgeInsets.only(top: 60, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () => Get.back(),
                        iconSize: 24,
                        padding: const EdgeInsets.only(left: 20),
                        splashRadius: 24,
                      ),
                      const Text(
                        "Notification",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 40), // To balance the back button spacing
                    ],
                  ),
                ),
                const SizedBox(height: 20),
            
                // Notifications List Container
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: GetBuilder<NotificationController>(
                        builder: (_) {
                          return AnimationLimiter(
                            child: ListView.separated(
                              itemCount: _.notifications.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(indent: 70, thickness: 0.5),
                              itemBuilder: (context, index) {
                                var notification = _.notifications[index];
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 500),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 20.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Icon with Color
                                            Icon(
                                              Icons.traffic,
                                              color: notification["iconColor"] as Color,
                                              size: 30,
                                            ),
                                            const SizedBox(width: 10),
            
                                            // Title and Subtitle
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    notification["title"] as String,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                notification["subtitle"] as String,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                                ],
                                              ),
                                            ),
            
                                            // Time at Trailing
                                            Text(
                                              notification["time"] as String,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}