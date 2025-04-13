// // verify_otp_controller.dart
// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ryd4ride/routing/app_routes.dart';

// import '../../constants/colors/app_colors.dart';

// class VerifyOtpController extends GetxController {
//   final List<TextEditingController> otpControllers =
//   List.generate(5, (_) => TextEditingController());
//   final List<FocusNode> focusNodes = List.generate(5, (_) => FocusNode());

//   var isResendEnabled = false.obs;
//   var timerSeconds = 30.obs;
//   Timer? _timer;

//   void moveToNextField(int index) {
//     if (index < otpControllers.length - 1) {
//       focusNodes[index + 1].requestFocus();
//     } else {
//       focusNodes[index].unfocus();
//     }
//   }

//   void verifyOtp() {
//     // Implement OTP verification logic here
//     // If successful, navigate to ChangePasswordScreen
//     Get.toNamed(AppRoutes.setnewPassword);
//   }

//   void startTimer() {
//     isResendEnabled.value = false;
//     timerSeconds.value = 30;
//     _timer?.cancel(); // Cancel any previous timer
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (timerSeconds.value > 0) {
//         timerSeconds.value--;
//       } else {
//         timer.cancel();
//         isResendEnabled.value = true;
//       }
//     });
//   }

//   @override
//   void onClose() {
//     _timer?.cancel(); // Ensure timer is canceled when controller is disposed
//     super.onClose();
//   }

//   void resendCode() {
//     if (isResendEnabled.value) {
//       startTimer();
//       // Trigger resend OTP logic here
//     }
//   }

//   Widget resendTimer(){
//     startTimer();
//     return  Obx(() => Column(
//       children: [
//         TextButton(
//           onPressed: resendCode,
//           child: Text(
//             isResendEnabled.value
//                 ? "Resend again"
//                 : "Didn’t receive any code? Resend again",
//             style: const TextStyle(
//                 color: AppColors.primaryColor,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 15
//             ),
//           ),
//         ),
//         Text(
//           "Request new code in 00:${timerSeconds.value.toString().padLeft(2, '0')}s",
//           style: const TextStyle(
//             color: Colors.black,
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     ));

//   }
// }
// import 'package:toolbox/constants/app_libraries.dart';
// import 'package:toolbox/utils/routing/app_routes.dart';

// class VerifyOtpController extends GetxController {
//   final formKey = GlobalKey<FormState>();

//   late String email;

//   List<TextEditingController> otpControllers =
//       List.generate(6, (index) => TextEditingController());

//   List<RxBool> isFilled = List.generate(6, (index) => false.obs);
//   var isOtpComplete = false.obs;

//   var countdownTime = 300.obs;
//   var canResendOtp = false.obs;

//   var otpCode = "".obs;

//   @override
//   void onInit() {
//     super.onInit();

//     email = Get.arguments["email"] ?? "Not Provided";

//     startCountdown();
//   }

//   void startCountdown() {
//     Future.delayed(Duration(seconds: 1), () {
//       if (countdownTime.value > 0) {
//         countdownTime.value--;
//         startCountdown();
//       } else {
//         canResendOtp.value = true;
//       }
//     });
//   }

//   String? validateOtpField(String? value) {
//     if (value == null || value.isEmpty) {
//       return "Enter OTP";
//     }
//     return null;
//   }

//   void updateOtp() {
//     otpCode.value = otpControllers.map((controller) => controller.text).join();
//     isOtpComplete.value = otpCode.value.length == 6; // Check if OTP is complete
//   }

//   Future<void> resendOtp() async {
//     canResendOtp.value = false;
//     countdownTime.value = 300;

//     final response = await Get.find<ApiService>().postRequest(
//       "auth/password/forgot/",
//       {"email": email},
//     );

//     if (response["success"]) {
//       CommonSnackBar.showSnackBar(title: "OTP Resent Successfully!");
//       startCountdown();
//     } else {
//       CommonSnackBar.showSnackBar(title: response["message"], isWarning: true);
//     }
//   }

//   void verifyOtp() {
//     if (otpCode.value.length == 6) {
//       Get.offAllNamed(
//         AppRoutes.setnewPassword,
//         arguments: {"email": email, "otp": otpCode.value}, // Pass OTP as argument
//       );
//       CommonSnackBar.showSnackBar(title: "OTP Verified", isWarning: false);
//     } else {
//       CommonSnackBar.showSnackBar(title: "Please enter a valid 6-digit OTP", isWarning: true);
//     }
//   }
// }

import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/routing/app_routes.dart';

class VerifyOtpController extends GetxController {
  final formKey = GlobalKey<FormState>();

  String email = '';
  late String phone;

  List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());

  List<RxBool> isFilled = List.generate(6, (index) => false.obs);
  var otpCode = "".obs;
  var isOtpComplete = false.obs;
  bool isLoading = true;

  var countdownTime = 300.obs;
  var canResendOtp = false.obs;
  final ApiService _apiService = Get.find<ApiService>();
  bool isRegister = false;
  bool isPasswordReset = false;
  @override
  void onReady() {
    super.onReady();
    // phone = Get.arguments['phone'] ?? '0000000';
    email = Get.arguments["email"] ?? "Not Provided";
    if (Get.arguments.containsKey("isRegister") &&
        Get.arguments["isRegister"] == true) {
      isRegister = true;
    } else {
      isRegister = false;
    }
    if (Get.arguments.containsKey("isPasswordReset") &&
        Get.arguments["isPasswordReset"] == true) {
      isPasswordReset = true;
    } else {
      isPasswordReset = false;
    }
    startCountdown();
    isLoading = false;
    update();
  }

  void startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (countdownTime.value > 0) {
        countdownTime.value--;
        startCountdown();
      } else {
        canResendOtp.value = true;
      }
    });
  }

  String? validateOtpField(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter OTP";
    }
    return null;
  }

  /// Update OTP when fields change
  void updateOtp() {
    otpCode.value = otpControllers.map((controller) => controller.text).join();
    isOtpComplete.value = otpCode.value.length == 6;
  }

  Future<void> resendCode() async {
    if (canResendOtp.value) {
      try {
        isLoading = true;
        update();

        // Call resend OTP API
        final response = await _apiService
            .postRequest('api/auth/resend-code', {'email': email});

        isLoading = false;
        update();
        print("The response in resend otp is${response}");

        if (response['data']['message'] ==
            'Verification code sent successfully') {
          CommonSnackBar.showSnackBar(
              title: 'A new verification code has been sent to your email',
              isWarning: false);
          canResendOtp.value = false;
          countdownTime.value = 300;
          //startCountdown();
        } else {
          CommonSnackBar.showSnackBar(
              title: 'Failed to Resend OTP', isWarning: true);
        }
      } catch (e) {
        isLoading = false;
        update();
        CommonSnackBar.showSnackBar(
            title: 'An unexpected error occurred while resending OTP',
            isWarning: true);
      }
    }
  }

  Future<bool> verifyOtp() async {
    if (otpCode.value.length != 6) {
      CommonSnackBar.showSnackBar(
          title: "Please enter a valid 6-digit OTP", isWarning: true);
      return false;
    }

    try {
      isLoading = true;
      update();

      final data = {
        'email': email,
        'code': otpCode.value,
      };

      var response;
      if (isPasswordReset == true) {
        response =
            await _apiService.postRequest('api/auth/verify-reset-code', data);
      } else {
        response = await _apiService.postRequest('api/auth/verify-code', data);
      }

      isLoading = false;
      update();

      if (response != null && response['data'] != null) {
        CommonSnackBar.showSnackBar(
            title: "OTP Verified Successfully", isWarning: false);

        if (isRegister == true) {
          Get.offAllNamed(AppRoutes.maps);
        } else if (isPasswordReset == true) {
          Get.toNamed(AppRoutes.setnewPassword, arguments: {
            "email": email,
            "otp": otpCode.value,
          });
        }

        return true;
      } else {
        CommonSnackBar.showSnackBar(
            title: response['message'] ?? "OTP not verified", isWarning: true);
        return false;
      }
    } catch (e) {
      isLoading = false;
      update();
      // Get.snackbar("Error", "An unexpected error occurred");
      return false;
    }
  }
}
