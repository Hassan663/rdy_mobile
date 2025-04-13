import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/controller/setting/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header with Back Button and Title
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
                    "Change Password",
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
                padding: const EdgeInsets.all(16.0),
                child: GetBuilder<ChangePasswordController>(
                  init: ChangePasswordController(),
                  builder: (controller) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          const Text(
                            "Change Password",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackButtoncolor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "For better security, make sure your password is at least 8 characters long and contains a mix of letters, numbers, and symbols.",
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.blackButtoncolor,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 50),
        
                          // Current Password Field
                          CommonTextField(
                            controller: controller.currentPasswordController,
                            hintText: "Current Password",
                            prefixIcon: Icons.lock_outline,
                            keyboardType: TextInputType.visiblePassword,
                            maxlines: 1,
                            togglePassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your current password";
                              }
                              return null;
                            },
                            isTextHidden: controller.currentPasswordHidden,
                            toggleIcon: controller.currentPasswordHidden
                                ? Icons.visibility_off_outlined
                                : Icons.remove_red_eye_outlined,
                            toggleFunction: () {
                              controller.toggleCurrentPasswordVisibility();
                            },
                          ).marginSymmetric(vertical: 15),
        
                          // New Password Field
                          CommonTextField(
                            controller: controller.newPasswordController,
                            hintText: "New Password",
                            prefixIcon: Icons.lock_outline,
                            keyboardType: TextInputType.visiblePassword,
                            maxlines: 1,
                            togglePassword: true,
                            validator: (value) {
                              if (value == null || value.length < 8) {
                                return "Password should be at least 8 characters";
                              }
                              return null;
                            },
                            isTextHidden: controller.newPasswordHidden,
                            toggleIcon: controller.newPasswordHidden
                                ? Icons.visibility_off_outlined
                                : Icons.remove_red_eye_outlined,
                            toggleFunction: () {
                              controller.toggleNewPasswordVisibility();
                            },
                          ).marginSymmetric(vertical: 15),
        
                          // Confirm New Password Field
                          CommonTextField(
                            controller: controller.confirmPasswordController,
                            hintText: "Confirm New Password",
                            prefixIcon: Icons.lock_outline,
                            keyboardType: TextInputType.visiblePassword,
                            maxlines: 1,
                            togglePassword: true,
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Password is required";
                              }else if (value !=
                                  controller.newPasswordController.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                            isTextHidden: controller.confirmPasswordHidden,
                            toggleIcon: controller.confirmPasswordHidden
                                ? Icons.visibility_off_outlined
                                : Icons.remove_red_eye_outlined,
                            toggleFunction: () {
                              controller.toggleConfirmPasswordVisibility();
                            },
                          ).marginOnly(top: 15, bottom: 50),
        
                          // Submit Button
                          Center(
                              child: CommonButton(
                                  text: "Change Password",
                                  onPressed: () {
                                    if (controller.validateForm()) {
                                      Get.snackbar("Success",
                                          "Password changed successfully!");
                                    } else {
                                      Get.snackbar("Error",
                                          "Please check the form for errors.");
                                    }
                                  })),
                        ],
                      ),
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
