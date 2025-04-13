// controller/subscription_controller.dart
import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  static var currentIndex = 1.obs;

  // Example packages data (replace with your actual data)
  List<Map<String, dynamic>> packages = [
    {
      "name": "Package 1",
      "price": "\$2",
      "billingCycle": "DAILY",
      "rate": "\$2 / Day",
      "features": [
        "Feature 1 description",
        "Feature 2 description",
        "Feature 3 description",
        "Feature 4 description",
        "Feature 5 description",
      ]
    },
    {
      "name": "Package 2",
      "price": "\$10",
      "billingCycle": "WEEKLY",
      "rate": "\$10 / Week",
      "features": [
        "Feature 1 description",
        "Feature 2 description",
        "Feature 3 description",
        "Feature 4 description",
        "Feature 5 description",
      ]
    },
    {
      "name": "Package 3",
      "price": "\$30",
      "billingCycle": "MONTHLY",
      "rate": "\$30 / Month",
      "features": [
        "Feature 1 description",
        "Feature 2 description",
        "Feature 3 description",
        "Feature 4 description",
        "Feature 5 description",
      ]
    },
  ];

  void onPageChanged(int index) {
    currentIndex.value = index;
  }
}