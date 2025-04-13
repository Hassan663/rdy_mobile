// screens/onboard_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/controller/setting/onboard_tutorial_controller.dart';

class OnBoardtutorialScreen extends StatelessWidget {
  const OnBoardtutorialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header
            Container(
              padding:
                  const EdgeInsets.only(top: 60, bottom: 20, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () => Get.back(),
                    iconSize: 24,
                    splashRadius: 24,
                  ),
                  const Text(
                    "OnBoard Tutorial",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 40), // Spacer for symmetry
                ],
              ),
            ),
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
                child: GetBuilder<OnBoardTutorialController>(
                  init: OnBoardTutorialController(),
                  builder: (_) {
                    return _.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            children: [
                              Expanded(
                                child: PageView.builder(
                                  controller: _.pageController,
                                  onPageChanged: _.onPageChanged,
                                  itemCount: _.cards.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      elevation: 3,
                                      color: const Color(0xffF6F6F6),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 10),
                                      shadowColor: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ListView(
                                        padding: const EdgeInsets.all(16),
                                        children: <Widget>[
                                          Image.asset(
                                            _.cards[index].imageUrl,
                                            fit: BoxFit.contain,
                                            height: 300,
                                          ).marginSymmetric(vertical: 30),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              _.cards[index].title,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              _.cards[index].description,
                                              textAlign: TextAlign.center,
                                              style:
                                                  const TextStyle(fontSize: 13.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Obx(() => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List<Widget>.generate(
                                      _.cards.length,
                                      (int index) {
                                        return AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          height: 10,
                                          width: 10,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 4.0),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: _.currentPage.value == index
                                                  ? AppColors.primaryColor
                                                  : AppColors.blackButtoncolor),
                                        );
                                      },
                                    ),
                                  )),
                              const SizedBox(height: 10),
                              const Text(
                                'For more tutorials, visit our channels:',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.blackButtoncolor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () => print("Facebook link here"),
                                    child: const CircleAvatar(
                                        backgroundColor: AppColors.primaryColor,
                                        child: Icon(
                                          Icons.facebook,
                                          color: Colors.white,
                                        )),
                                  ),
                                  GestureDetector(
                                    onTap: () => print("YouTube link here"),
                                    child: const CircleAvatar(
                                        backgroundColor: AppColors.primaryColor,
                                        child: Icon(
                                          Icons.youtube_searched_for,
                                          color: Colors.white,
                                        )),
                                  ),
                                  GestureDetector(
                                    onTap: () => print("Instagram link here"),
                                    child: const CircleAvatar(
                                        backgroundColor: AppColors.primaryColor,
                                        child: Icon(
                                          Icons.youtube_searched_for,
                                          color: Colors.white,
                                        )),
                                  ),
                                ],
                              ).marginSymmetric(vertical: 10),
                              CommonButton(
                                text: 'Skip',
                                onPressed: () {
                                  _.skipToNextPage();
                                },
                                color: AppColors.primaryColor,
                              ).marginSymmetric(vertical: 20)
                            ],
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
