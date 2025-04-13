import 'dart:async';
import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/routing/app_routes.dart';
import 'package:ryd4ride/services/apis/apis_services.dart';

class RegisterController extends GetxController {
  // OTP related controllers and nodes - updated to 6 digits
  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  // Form controllers
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Phone code separate from number
  RxString phoneCode = '+1'.obs;

  // Observables for form state
  RxBool isPrivacyPolicyAccepted = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  RxBool isLoading = false.obs;
  RxBool hasValidationErrors = false.obs;
  RxString validationErrorMessage = ''.obs;

  // API service
  final ApiService _apiService = Get.find<ApiService>();

  // Timer-related variables
  RxBool isResendEnabled = false.obs;
  RxInt timerSeconds = 60.obs;

  // Password validation regex patterns
  final RegExp hasLowerCase = RegExp(r'[a-z]');
  final RegExp hasUpperCase = RegExp(r'[A-Z]');
  final RegExp hasNumber = RegExp(r'[0-9]');
  final RegExp hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  @override
  void onInit() {
    super.onInit();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void togglePrivacyPolicy() {
    isPrivacyPolicyAccepted.value = !isPrivacyPolicyAccepted.value;
  }

  void moveToNextField(int index) {
    if (index < otpControllers.length - 1) {
      focusNodes[index + 1].requestFocus();
    } else {
      focusNodes[index].unfocus();
    }
  }

  void moveToPreviousField(int index) {
    if (index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  void updatePhoneCode(String code) {
    phoneCode.value = code;
  }

  bool validateForm() {
    hasValidationErrors.value = false;
    validationErrorMessage.value = '';

    // Check if fields are empty
    if (firstNameController.text.isEmpty) {
      hasValidationErrors.value = true;
      validationErrorMessage.value = 'First name is required';
      return false;
    }

    if (lastNameController.text.isEmpty) {
      hasValidationErrors.value = true;
      validationErrorMessage.value = 'Last name is required';
      return false;
    }

    if (emailController.text.isEmpty) {
      hasValidationErrors.value = true;
      validationErrorMessage.value = 'Email is required';
      return false;
    }

    // Validate email format
    if (!GetUtils.isEmail(emailController.text)) {
      hasValidationErrors.value = true;
      validationErrorMessage.value = 'Enter a valid email';
      return false;
    }

    if (phoneController.text.isEmpty) {
      hasValidationErrors.value = true;
      validationErrorMessage.value = 'Phone number is required';
      return false;
    }

    if (passwordController.text.isEmpty) {
      hasValidationErrors.value = true;
      validationErrorMessage.value = 'Password is required';
      return false;
    }

    // Password validation
    if (!validatePasswordRequirements(passwordController.text)) {
      hasValidationErrors.value = true;
      validationErrorMessage.value = 'Password does not meet requirements';
      return false;
    }

    // Confirm password
    if (confirmPasswordController.text != passwordController.text) {
      hasValidationErrors.value = true;
      validationErrorMessage.value = 'Passwords do not match';
      return false;
    }

    // Check if privacy policy is accepted
    if (!isPrivacyPolicyAccepted.value) {
      hasValidationErrors.value = true;
      validationErrorMessage.value =
          'Please accept the Privacy Policy and Terms & Conditions';
      return false;
    }

    return true;
  }

  bool validatePasswordRequirements(String password) {
    return password.length >= 8 &&
        hasLowerCase.hasMatch(password) &&
        hasUpperCase.hasMatch(password) &&
        hasNumber.hasMatch(password) &&
        hasSpecialChar.hasMatch(password);
  }

  Future<void> onSignUpPressed() async {
    if (validateForm()) {
      try {
        isLoading.value = true;

        // Prepare user data for API call - combining first and last name
        final userData = {
          'name': '${firstNameController.text} ${lastNameController.text}',
          'email': emailController.text,
          'country_code': phoneCode.value,
          'phone': phoneController.text,
          'password': passwordController.text,
          'status': true,
          'fcm_token': 'sdlkjfsdlkjfslkjd32lkj4lkj24'
        };

        // Call registration API
        final response =
            await _apiService.postRequest('api/auth/signup', userData);

        isLoading.value = false;
        print("The  is ${response}");

        if (response['data']['data']['email'] != null) {
          CommonSnackBar.showSnackBar(
              title: 'User Registered Please Verify your OTP now',
              isWarning: false);
          Get.toNamed(AppRoutes.verifyotp, arguments: {
            "email": response['data']['data']['email'],
            "isRegister": true
          });
        } else {
          CommonSnackBar.showSnackBar(
              title: response['message'] ??
                  'An error occurred during registration',
              isWarning: true);
        }
      } catch (e) {
        isLoading.value = false;
        CommonSnackBar.showSnackBar(
            title: 'An error occurred during registration', isWarning: true);
      }
    } else {
      // Show validation error message
      CommonSnackBar.showSnackBar(title: 'Validation Error', isWarning: true);
    }
  }

  @override
  void onClose() {
    // Dispose all controllers to prevent memory leaks
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    for (var node in focusNodes) {
      node.dispose();
    }

    super.onClose();
  }
}
