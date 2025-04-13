// // change_password_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ryd4ride/routing/app_routes.dart';

// class SetNewPasswordController extends GetxController {
//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   var isNewPasswordHidden = true.obs;
//   var isConfirmPasswordHidden = true.obs;

//   void toggleNewPasswordVisibility() {
//     isNewPasswordHidden.value = !isNewPasswordHidden.value;
//     update();
//   }

//   void toggleConfirmPasswordVisibility() {
//     isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
//     update();
//   }

//   void saveNewPassword() {
//     if (newPasswordController.text == confirmPasswordController.text) {
//       // Save new password logic here
//       Get.snackbar("Success", "Password changed successfully.");
//       Get.toNamed(AppRoutes.maps);
//     } else {
//       Get.snackbar("Error", "Passwords do not match.");
//     }
//   }
// }
import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/routing/app_routes.dart';

class ResetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();

  String? email;
  bool isLoading = true;

  // Password fields
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // Password visibility
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  // Show validation messages only when the button is pressed
  var showValidationMessages = false.obs;
  var otpCode = '';

  @override
  void onReady() {
    super.onReady();
    otpCode = Get.arguments['otp'];
    email = Get.arguments["email"] ?? "";
    isLoading = false;
    update();
  }

  // ✅ New Password Validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter new password";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }

  // ✅ Confirm Password Validation
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter confirm password";
    }
    if (value != newPasswordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  Future<void> resetPassword() async {
    showValidationMessages.value = true;

    if (formKey.currentState!.validate()) {
      isLoading = true;
      update();

      final response = await Get.find<ApiService>().patchRequest(
        "api/auth/reset-password",
        {
          "email": email,
          "new_password": newPasswordController.text.trim(),
          "code": otpCode
        },
      );

      isLoading = false;
      update();

      if (response["success"]) {
        CommonSnackBar.showSnackBar(title: "Password reset successful!");
        Get.offAllNamed(AppRoutes.login); // Navigate to login
      } else {
        CommonSnackBar.showSnackBar(
            title: response["message"], isWarning: true);
      }
    }
  }
}
