import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/routing/app_routes.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();

  // Loading state
  bool isLoading = false;

  // Show validation messages
  var showValidationMessages = false.obs;

  @override
  onReady() {
    isLoading = false;
    update();
    super.onReady();
  }

  // ✅ Email validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter email";
    }

    Pattern pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern as String);

    if (!regex.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  Future<void> sendResetLink() async {
    showValidationMessages.value = true;

    if (validateEmail(emailController.text) == null) {
      isLoading = true;
      update();

      final String email = emailController.text.trim();
      print(
          "[ForgotPasswordController] Attempting to send reset link to $email");

      final response = await Get.find<ApiService>().postRequest(
        "api/auth/forgot-password",
        {"email": email},
      );

      print("[ForgotPasswordController] API Response: $response");

      if (response["success"] && response["status"] == 200) {
        CommonSnackBar.showSnackBar(title: "Password reset code sent!");

        print("[ForgotPasswordController] Navigating to VerifyOtpScreen...");

        // ✅ Move to OTP screen on success
        Get.toNamed(AppRoutes.verifyotp, arguments: {
          "email": emailController.text,
          "isPasswordReset": true
        });
      } else {
        print(
            "[ForgotPasswordController] Password reset failed: ${response["message"]}");
        CommonSnackBar.showSnackBar(
            title: response["message"], isWarning: true);
      }

      isLoading = false;
      update();
    } else {
      print(
          "[ForgotPasswordController] Validation failed for email: ${emailController.text}");
      CommonSnackBar.showSnackBar(
          title: "Please enter a valid email address.", isWarning: true);
    }
  }
}
