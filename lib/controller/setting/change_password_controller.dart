// controllers/change_password_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers for the password fields
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // State variables for password visibility
  bool currentPasswordHidden = true;
  bool newPasswordHidden = true;
  bool confirmPasswordHidden = true;

  // Toggle visibility functions
  void toggleCurrentPasswordVisibility() {
    currentPasswordHidden = !currentPasswordHidden;
    update();
  }

  void toggleNewPasswordVisibility() {
    newPasswordHidden = !newPasswordHidden;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    confirmPasswordHidden = !confirmPasswordHidden;
    update();
  }

  // Validate the form
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}