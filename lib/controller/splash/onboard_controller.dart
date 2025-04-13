// controllers/onboard_tutorial_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ryd4ride/constants/libraries/app_libraries.dart';

class OnBoardController extends GetxController {
  bool isLoading = true;
  final storage = GetStorage();

  var currentPage = 0.obs;
  final List<CardItem> cards = [
    CardItem(
      imageUrl: AppAssets.onBoard,
      title: 'RDY4Ride',
      description:
          "Passengers are RDY4Ride, Be the first to arrive and make it easy to choose you! Select any Light \"Green\" 1,000 or more looking for a ride, \"Yellow\" 600 or less and \"Red\" 400 or less. Passengers looking for you! Don't keep them waiting..",
    ),
    CardItem(
      imageUrl: AppAssets.onBoard,
      title: 'RDY4Ride',
      description:
      "Passengers are RDY4Ride, Be the first to arrive and make it easy to choose you! Select any Light \"Green\" 1,000 or more looking for a ride, \"Yellow\" 600 or less and \"Red\" 400 or less. Passengers looking for you! Don't keep them waiting..",
    ),
    // CardItem(
    //   imageUrl: AppAssets.onBoard,
    //   title: 'Save Events and Plan Routes',
    //   description:
    //       'Save upcoming events where passengers might gather and get the best routes to reach there. Ensure you never miss out on high-traffic events with easy navigation assistance.',
    // ),
    // CardItem(
    //   imageUrl: AppAssets.onBoard,
    //   title: 'Flexible Payment Options',
    //   description:
    //       'Choose from daily, monthly, or yearly subscription plans based on your needs. Pay securely through the app to access all premium features without hassle.',
    // ),
    // CardItem(
    //   imageUrl: AppAssets.onBoard,
    //   title: 'Real-Time Notifications',
    //   description:
    //       'Receive real-time notifications on high-passenger areas, new events, or important updates. Enable notifications to ensure you don’t miss any important information.',
    // ),
  ];

  final PageController pageController = PageController(viewportFraction: 1);

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  @override
  void onReady() {
    isLoading = false;
    update();
    super.onReady();
  }

  void skipToNextPage() {
    if (currentPage.value < cards.length - 1) {
      currentPage.value++;
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }
}

class CardItem {
  final String imageUrl;
  final String title;
  final String description;

  CardItem(
      {required this.imageUrl, required this.title, required this.description});
}
