import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/routing/app_routes.dart';

class LoginController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers
  final passwordController = TextEditingController();
  final emailOrPhoneController = TextEditingController();

  // Observable variables
  var isLoading = false;
  var checkbox = true;
  var passwordshown = true.obs;
  // var isEmailShown = 1.obs;

  // Storage keys
  static const String EMAIL_KEY = 'saved_email';
  static const String PASSWORD_KEY = 'saved_password';
  static const String TOKEN_KEY = 'access_token';

  @override
  void onInit() {
    super.onInit();
    _loadSavedCredentials();
  }

  // Load saved credentials if they exist
  void _loadSavedCredentials() {
    final box = GetStorage();
    final savedEmail = box.read<String>(EMAIL_KEY);
    final savedPassword = box.read<String>(PASSWORD_KEY);

    if (savedEmail != null && savedPassword != null) {
      emailOrPhoneController.text = savedEmail;
      passwordController.text = savedPassword;
      checkbox = true;
      update();
    }
  }

  // Save credentials based on checkbox state
  void _handleCredentialStorage(String email, String password, String token) {
    final box = GetStorage();

    // Always save token
    box.write(TOKEN_KEY, token);

    if (checkbox) {
      box.write(EMAIL_KEY, email);
      box.write(PASSWORD_KEY, password);
      update();
    } else {
      box.remove(EMAIL_KEY);
      box.remove(PASSWORD_KEY);
      update();
    }
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    passwordshown.value = !passwordshown.value;
  }

  // // Toggle between email and phone input
  // void toggleInputType() {
  //   isEmailShown.value = isEmailShown.value == 1 ? 0 : 1;
  // }

  // Validate password with required criteria
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }

    // Check for uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Password must contain at least one uppercase letter";
    }

    // Check for lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Password must contain at least one lowercase letter";
    }

    // Check for special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return "Password must contain at least one special character";
    }

    return null;
  }

  // Validate email format
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);

    return (!regex.hasMatch(value)) ? 'Please enter a valid email' : null;
  }

  // Validate phone number
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }

    if (value.length < 5) {
      return "Please enter a valid phone number";
    }

    return null;
  }

  // Validate form input
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  // Login user with API
  Future<bool> loginUser() async {
    if (!validateForm()) {
      Get.snackbar("Error", "Please correct the form errors");
      return false;
    }

    try {
      isLoading = true;
      update();

      final data = {
        // isEmailShown.value == 1 ? 'email' : 'phone':
        //     emailOrPhoneController.text,
        'email': emailOrPhoneController.text,
        'password': passwordController.text
      };

      final response = await _apiService.postRequest('api/auth/signin', data);

      if (response['success']) {
        // Extract token from response
        final token = response['data']['data']?['token'] ?? '';

        // Save credentials based on checkbox state
        _handleCredentialStorage(
            emailOrPhoneController.text, passwordController.text, token);

        CommonSnackBar.showSnackBar(
            title: "Login successful", isWarning: false);
        Get.offAllNamed(AppRoutes.maps);
        print("The token is ${token}");

        return true;
      } else {
        Get.snackbar("Error", response['message'] ?? "Login failed");
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred");
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onClose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
