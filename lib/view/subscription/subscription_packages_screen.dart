// screens/subscription_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/controller/subscription/subscription_packages_controller.dart';

import '../../routing/app_routes.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: GetBuilder<SubscriptionController>(
            init: SubscriptionController(),
            builder: (_) {
              return Column(
                children: [
                  // Custom Header
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
                          "Packages",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                            width: 40), // To balance the back button spacing
                      ],
                    ),
                  ),
                  // const Text(
                  //   "Choose a subscription package that fits your needs and Get Started!",
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w500),
                  //   textAlign: TextAlign.start,
                  // ).marginSymmetric(horizontal: 20, vertical: 20),
                  const SizedBox(height: 20),
        
                  // White Container with Rounded Top Corners
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
                          padding: const EdgeInsets.only(top: 5),
                          child: ListView.builder(
                            itemCount: _.packages.length,
                            itemBuilder: (context, index) {
                              var package = _.packages[index];
                              return newpackagecard(package);
                            },
                          ),
                        )
        
                        // Column(
                        //   children: [
        
                        // CarouselSlider.builder(
                        //   itemCount: _.packages.length,
                        //   options: CarouselOptions(
                        //     height: Get.height * 0.55,
                        //     // viewportFraction: 0.85,
                        //     // enlargeCenterPage: true,
                        //     reverse: true,
                        //     enableInfiniteScroll: false,
                        //     onPageChanged: (index, reason) {
                        //       _.onPageChanged(index);
                        //     },
                        //   ),
                        //   itemBuilder: (context, index, realIndex) {
                        //     var package = _.packages[index];
                        //     // Scale the focused card
                        //     return Obx(() {
                        //       double scale =
                        //           _.currentIndex.value == index ? 1.0 : 0.9;
                        //       return Transform.scale(
                        //         scale: scale,
                        //         child: PackageCard(package: package),
                        //       );
                        //     });
                        //   },
                        // ),
                        // // Dot Indicators
                        // Obx(() => Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: List.generate(
                        //         _.packages.length,
                        //         (index) => AnimatedContainer(
                        //           duration: const Duration(milliseconds: 2000),
                        //           margin:
                        //               const EdgeInsets.symmetric(horizontal: 4),
                        //           height: 8,
                        //           width: _.currentIndex.value == index ? 20 : 8,
                        //           decoration: BoxDecoration(
                        //             color: _.currentIndex.value == index
                        //                 ? Colors.blue.shade900
                        //                 : Colors.grey,
                        //             borderRadius: BorderRadius.circular(4),
                        //           ),
                        //         ),
                        //       ),
                        //     )).marginOnly(top: 40),
                        // ],
                        // ).marginOnly(top: 50),
                        ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

newpackagecard(Map<String, dynamic> package) {
  return Card(
    elevation: 5,
    margin: EdgeInsets.all(15),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
              height: 100,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        package["name"],
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        package["billingCycle"],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        package["price"],
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        package["rate"],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ).marginSymmetric(horizontal: 20, vertical: 20)),
          ExpansionTile(
            title: Text("Features"),
            children: [
              ...package["features"].map<Widget>((feature) {
                return Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor),
                      child: Center(
                          child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      )),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feature,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ).marginSymmetric(horizontal: 20, vertical: 10);
              }).toList(),
            ],
          ),
          Center(
              child: CommonButton(
                  width: Get.width - 60,
                  text: "Subsctibe",
                  onPressed: () {
                    newbottomsheet();
                  })).marginOnly(top: 20),
        ],
      ),
    ),
  );
}
// PackageCard Widget
// class PackageCard extends StatelessWidget {
//   final Map<String, dynamic> package;
//
//   const PackageCard({Key? key, required this.package}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//               height: 100,
//               decoration: const BoxDecoration(
//                 color: AppColors.primaryColor,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(15),
//                   topRight: Radius.circular(15),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         package["name"],
//                         style: const TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                       Text(
//                         package["billingCycle"],
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         package["price"],
//                         style: TextStyle(
//                             fontSize: 26,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                       Text(
//                         package["rate"],
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ).marginSymmetric(horizontal: 20, vertical: 20)),
//           const Text(
//             'Features You will get',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ).marginAll(20),
//           ...package["features"].map<Widget>((feature) {
//             return Row(
//               children: [
//                 const Icon(
//                   Icons.check_circle_outline,
//                   color: AppColors.primaryColor,
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     feature,
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                 ),
//               ],
//             ).marginSymmetric(horizontal: 20, vertical: 10);
//           }).toList(),
//           // const Spacer(),
//           Center(child: CommonButton(text: "Subsctibe", onPressed: () {}))
//               .marginOnly(top: 20),
//         ],
//       ),
//     );
//   }
// }

newbottomsheet() {
  print(Get.height);
  return Get.bottomSheet(Container(
    padding: EdgeInsets.all(20),
    height: Get.height * 0.6,
    width: Get.width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20), topLeft: Radius.circular(20)),
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 6,
            width: 60,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(3)),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Payment Method",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: Colors.grey.shade500),
          ),
          SizedBox(
            height: 40,
          ),
          listtileforpackage(
              title: "Zelle",
              radiovalue: 1,
              imagepaths: ["assets/images/z.png"]),
          SizedBox(
            height: 10,
          ),
          listtileforpackage(
              title: "Cash App",
              radiovalue: 2,
              imagepaths: ["assets/images/s.png"]),
          SizedBox(
            height: 10,
          ),
          listtileforpackage(
              title: "5967",
              radiovalue: 3,
              imagepaths: ["assets/images/money.png","assets/images/visa.png"]),
          SizedBox(height: 15,),
          Center(
              child: CommonButton(
                  width: Get.width - 80,
                  text: "Pay Now",
                  onPressed: () {
                    Get.toNamed(AppRoutes.addCard);
                  })).marginOnly(top: 20),
        ],
      ),
    ),
  ));
}

listtileforpackage(
    {required radiovalue, required title, required List imagepaths}) {
  return Card(
    elevation: 20,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Obx(
          () => Radio<int>(
            
            fillColor: WidgetStatePropertyAll(AppColors.primaryColor),
            value: radiovalue,
            groupValue: SubscriptionController.currentIndex.value,
            onChanged: (value) {
              SubscriptionController.currentIndex.value = value!;
            },
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize
              .min, // This ensures the row takes only the required space
          children: List.generate(imagepaths.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset(
                imagepaths[index],
                width: 50, // Adjust the size of the images
                height: 50,
              ),
            );
          }),
        ),
      ),
    ),
  );
}
