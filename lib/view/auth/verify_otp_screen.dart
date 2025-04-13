// // verify_otp_screen.dart
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ryd4ride/constants/libraries/app_libraries.dart';
// import 'package:ryd4ride/controller/auth/verify_otp_controller.dart';
// import 'package:ryd4ride/view/auth/set_new_password_screen.dart';
// import 'package:ryd4ride/widgets/common_button.dart';

// class VerifyOtpScreen extends StatelessWidget {
//   const VerifyOtpScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primaryColor,
//       body: bodyData(context),
//     );
//   }

//   Widget bodyData(BuildContext context) {
//     final double containerHeight = MediaQuery.of(context).size.height * 0.6;

//     return GetBuilder<VerifyOtpController>(
//       init: VerifyOtpController(),
//       builder: (controller) {
//         return Stack(
//           children: [
//             // Background logo with blur effect
//             Positioned.fill(
//               child: Stack(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(80.0),
//                     child: Image.asset(
//                       AppAssets.appLogo,
//                       color: Colors.white,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   Positioned.fill(
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
//                       child: Container(
//                         color: Colors.black.withOpacity(0.2),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 height: containerHeight,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Forgot Password',
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.blackButtoncolor,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       const Text(
//                         'Please enter the 4-digit code sent to your email for verification.',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: AppColors.blackButtoncolor,
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: List.generate(5, (index) {
//                           return SizedBox(
//                             width: 50,
//                             height: 50,
//                             child: TextField(
//                               controller: controller.otpControllers[index],
//                               focusNode: controller.focusNodes[index],
//                               textAlign: TextAlign.center,
//                               maxLength: 1,
//                               keyboardType: TextInputType.number,
//                               decoration: InputDecoration(
//                                 counterText: '',
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(
//                                     color: controller.otpControllers[index].text
//                                             .isNotEmpty
//                                         ? AppColors.primaryColor
//                                         : Colors.grey,
//                                   ),
//                                 ),
//                                 filled: true,
//                                 fillColor: controller
//                                         .otpControllers[index].text.isNotEmpty
//                                     ? Colors.white
//                                     : Colors.grey.shade200,
//                               ),
//                               onChanged: (value) {
//                                 if (value.isNotEmpty) {
//                                   controller.moveToNextField(index);
//                                 }
//                               },
//                             ),
//                           );
//                         }),
//                       ),
//                       const SizedBox(height: 60),
//                       Center(
//                         child: Column(
//                           children: [
//                             VerifyOtpController().resendTimer(),
//                             const SizedBox(height: 30,),
//                             CommonButton(
//                               text: 'Verify',
//                               width: 300,
//                               onPressed: controller.verifyOtp,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// newverify_otp(){
//   final controller=Get.put(VerifyOtpController());

//   return Get.bottomSheet(
//     Container(
//       height: Get.height*0.6,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//         // boxShadow: [
//         //   BoxShadow(
//         //     color: Colors.black.withOpacity(0.1),
//         //     spreadRadius: 5,
//         //     blurRadius: 10,
//         //   ),
//         // ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Container(
//                   height: 6,
//                   width: 60,
//                   decoration: BoxDecoration(
//                       color: Colors.grey,
//                       borderRadius: BorderRadius.circular(20)
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20,),
//               const Text(
//                 'Forgot Password',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.blackButtoncolor,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'Please enter the 4-digit code sent to your email for verification.',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: AppColors.blackButtoncolor,
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: List.generate(5, (index) {
//                   return SizedBox(
//                     width: 50,
//                     height: 50,
//                     child: TextField(
//                       controller: controller.otpControllers[index],
//                       focusNode: controller.focusNodes[index],
//                       textAlign: TextAlign.center,
//                       maxLength: 1,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         counterText: '',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(
//                             color: controller.otpControllers[index].text
//                                 .isNotEmpty
//                                 ? AppColors.primaryColor
//                                 : Colors.grey,
//                           ),
//                         ),
//                         filled: true,
//                         fillColor: controller
//                             .otpControllers[index].text.isNotEmpty
//                             ? Colors.white
//                             : Colors.grey.shade200,
//                       ),
//                       onChanged: (value) {
//                         if (value.isNotEmpty) {
//                           controller.moveToNextField(index);
//                         }
//                       },
//                     ),
//                   );
//                 }),
//               ),
//               const SizedBox(height: 60),
//               Center(
//                 child: Column(
//                   children: [
//                     VerifyOtpController().resendTimer(),
//                     const SizedBox(height: 30,),
//                     CommonButton(
//                       text: 'Verify',
//                       width: 300,
//                       onPressed:() {
//                         Get.back();
//                         Get.back();
//                         newsetpassword();
//                       }
//                       // controller.verifyOtp,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }

import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/controller/auth/verify_otp_controller.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyOtpController>(
      init: VerifyOtpController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Get.back(),
            ),
            title: const MyText(
              text: "Verify OTP",
              fontFamily: "Lato",
              fontSize: 18,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            centerTitle: true,
            backgroundColor: AppColors.primaryColor,
            elevation: 4,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text(
                  "Enter the 6-digit OTP sent to your ${controller.email}", // Fix: Updated text from 4 to 6
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sora(
                      fontSize: 16, color: AppColors.primaryColor),
                ),
                const SizedBox(height: 30),

                /// OTP Fields
                Form(
                  key: controller.formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      6, // Fix: Ensure 6 OTP fields are generated
                      (index) => Obx(() => SizedBox(
                            width: 50,
                            height: 70,
                            child: TextFormField(
                              controller: controller.otpControllers[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                counterText: "",
                                filled: true,
                                // fillColor: AppColors.bgColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: controller.isFilled[index].value
                                          ? AppColors.primaryColor
                                          : Colors.grey),
                                ),
                              ),
                              validator: controller.validateOtpField,
                              onChanged: (value) {
                                if (value.isNotEmpty && index < 5) {
                                  // Fix: Changed 3 to 5
                                  FocusScope.of(context).nextFocus();
                                } else if (value.isEmpty && index > 0) {
                                  // Allow backspace navigation
                                  FocusScope.of(context).previousFocus();
                                }
                                controller.updateOtp(); // Ensure OTP is updated
                              },
                            ),
                          )),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// Resend OTP Timer
                Obx(() => controller.canResendOtp.value
                    ? TextButton(
                        onPressed: controller.resendCode,
                        child: const Text("Resend OTP",
                            style: TextStyle(
                                fontSize: 16,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600)))
                    : Text(
                        "OTP will Expires in ${controller.countdownTime.value ~/ 60}:${(controller.countdownTime.value % 60).toString().padLeft(2, '0')}",
                        style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600),
                      )),

                const SizedBox(height: 40),

                CommonButton(text: "Verify", onPressed: controller.verifyOtp)
              ],
            ),
          ),
        );
      },
    );
  }
}
