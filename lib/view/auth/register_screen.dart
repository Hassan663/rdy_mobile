import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/controller/auth/register_controller.dart';
import 'package:ryd4ride/routing/app_routes.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: controller.formKey,
                  autovalidateMode:
                      AutovalidateMode.disabled, // Disable automatic validation
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      _buildPersonalInfoFields(controller),
                      _buildPasswordFields(controller),
                      _buildPasswordRequirements(),
                      _buildPrivacyPolicyCheckbox(controller),
                      _buildSignUpButton(controller),
                      _buildGuestSignIn(),
                      _buildDivider(),
                      _buildSocialLoginButtons(),
                      _buildLoginRedirect(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            AppAssets.appLogo,
            width: 130,
          ).marginOnly(bottom: 10, top: 20),
        ),
        const Text(
          "Signup",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        const Text(
          "Fill the fields to signup",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ).marginOnly(top: 5),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildPersonalInfoFields(RegisterController controller) {
    return Column(
      children: [
        CommonTextField(
          controller: controller.firstNameController,
          hintText: "First Name",
          prefixIcon: Icons.person,
        ),
        const SizedBox(height: 15),
        CommonTextField(
          controller: controller.lastNameController,
          hintText: "Last Name",
          prefixIcon: Icons.person,
        ),
        const SizedBox(height: 15),
        CommonTextField(
          controller: controller.emailController,
          hintText: "Enter Email",
          prefixIcon: Icons.email,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 15),
        IntlPhoneField(
          controller: controller.phoneController,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(),
            ),
          ),
          disableLengthCheck: true,
          initialCountryCode: 'US',
          onChanged: (phone) {
            controller.updatePhoneCode(phone.countryCode);
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildPasswordFields(RegisterController controller) {
    return Obx(() => Column(
          children: [
            CommonTextField(
              controller: controller.passwordController,
              hintText: "Password",
              prefixIcon: Icons.lock,
              isTextHidden: !controller.isPasswordVisible.value,
              // suffixIcon: IconButton(
              //   icon: Icon(
              //     controller.isPasswordVisible.value
              //         ? Icons.visibility_off
              //         : Icons.visibility,
              //   ),
              //   onPressed: () => controller.togglePasswordVisibility(),
              // ),
            ),
            const SizedBox(height: 15),
            CommonTextField(
              controller: controller.confirmPasswordController,
              hintText: "Confirm Password",
              prefixIcon: Icons.lock,
              isTextHidden: !controller.isConfirmPasswordVisible.value,
              // suffixIcon: IconButton(
              //   icon: Icon(
              //     controller.isConfirmPasswordVisible.value
              //         ? Icons.visibility_off
              //         : Icons.visibility,
              //   ),
              //   onPressed: () => controller.toggleConfirmPasswordVisibility(),
              // ),
            ),
          ],
        ));
  }

  Widget _buildPasswordRequirements() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 20),
      child: RichText(
        text: const TextSpan(
          style: TextStyle(fontSize: 12, color: Colors.grey),
          children: [
            TextSpan(text: "Your password must include:\n"),
            TextSpan(text: "• At least 8 characters\n"),
            TextSpan(text: "• At least one lowercase letter\n"),
            TextSpan(text: "• At least one uppercase letter\n"),
            TextSpan(text: "• At least one number\n"),
            TextSpan(text: "• At least one special character"),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyPolicyCheckbox(RegisterController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Checkbox(
              value: controller.isPrivacyPolicyAccepted.value,
              onChanged: (val) => controller.togglePrivacyPolicy(),
            )),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: RichText(
              text: TextSpan(
                text: "I have accepted the ",
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: "Privacy Policy",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Handle Privacy Policy click
                        print("Privacy Policy clicked");
                      },
                  ),
                  const TextSpan(text: " and "),
                  TextSpan(
                    text: "Terms and Conditions",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Handle Terms and Conditions click
                        print("Terms and Conditions clicked");
                      },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ).marginOnly(top: 20);
  }

  Widget _buildSignUpButton(RegisterController controller) {
    return Center(
      child: Obx(() => CommonButton(
            text: controller.isLoading.value ? "Signing Up..." : "Sign Up",
            width: Get.width - 50,
            onPressed: () {
              controller.isLoading.value ? null : controller.onSignUpPressed();
            },
          ).marginOnly(top: 20)),
    );
  }

  Widget _buildGuestSignIn() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TextButton(
        onPressed: () {
          Get.offAllNamed(AppRoutes.maps);
        },
        child: const Text(
          "Guest Sign In",
          style: TextStyle(
            fontSize: 18,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.primaryColor,
            thickness: 1,
            indent: 30,
            endIndent: 10,
          ),
        ),
        Text(
          "OR",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.primaryColor,
            thickness: 1,
            indent: 10,
            endIndent: 30,
          ),
        ),
      ],
    ).marginSymmetric(vertical: 10);
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          maxRadius: 30,
          backgroundColor: AppColors.primaryColor,
          child: Center(
            child: IconButton(
              onPressed: () {},
              icon: Image.asset(
                AppAssets.googlelogo,
                width: 25,
              ),
              color: AppColors.blackButtoncolor,
            ),
          ),
        ).marginOnly(right: 20),
        CircleAvatar(
          maxRadius: 30,
          backgroundColor: AppColors.primaryColor,
          child: Center(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.apple,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginRedirect() {
    return Center(
      child: Text.rich(
        TextSpan(
          text: "Already have an account? ",
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.blackButtoncolor,
          ),
          children: <InlineSpan>[
            TextSpan(
              text: 'Login',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.offAllNamed(AppRoutes.login);
                },
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ).marginOnly(bottom: 20, top: 30),
    );
  }
}
