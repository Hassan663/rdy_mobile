// import 'dart:ui';

// import 'package:ryd4ride/constants/libraries/app_libraries.dart';
// import 'package:ryd4ride/controller/auth/set_new_password_controller.dart';

// class SetNewPasswordScreen extends StatelessWidget {
//   const SetNewPasswordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primaryColor,
//       body: bodyData(context),
//     );
//   }

//   Widget bodyData(BuildContext context) {
//     final double containerHeight = MediaQuery.of(context).size.height * 0.6;

//     return GetBuilder<SetNewPasswordController>(
//       init: SetNewPasswordController(),
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
//                         'Set New Password',
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.blackButtoncolor,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       const Text(
//                         'Enter your new password.',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: AppColors.blackButtoncolor,
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       CommonTextField(
//                         controller: controller.newPasswordController,
//                         hintText: "New Password",
//                         prefixIcon: Icons.lock_outline,
//                         keyboardType: TextInputType.visiblePassword,
//                         togglePassword: true,
//                         isTextHidden: controller.isNewPasswordHidden.value,
//                         toggleIcon: controller.isNewPasswordHidden.value
//                             ? Icons.visibility_off
//                             : Icons.visibility,
//                         toggleFunction: controller.toggleNewPasswordVisibility,
//                       ),
//                       const SizedBox(height: 20),
//                       CommonTextField(
//                         controller: controller.confirmPasswordController,
//                         hintText: "Confirm Password",
//                         prefixIcon: Icons.lock_outline,
//                         keyboardType: TextInputType.visiblePassword,
//                         togglePassword: true,
//                         isTextHidden: controller.isConfirmPasswordHidden.value,
//                         toggleIcon: controller.isConfirmPasswordHidden.value
//                             ? Icons.visibility_off
//                             : Icons.visibility,
//                         toggleFunction:
//                             controller.toggleConfirmPasswordVisibility,
//                       ),
//                       const SizedBox(height: 60),
//                       Center(
//                         child: CommonButton(
//                           text: 'Save',
//                           width: 300,
//                           onPressed: controller.saveNewPassword,
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

// newsetpassword(){
//   final controller=Get.put(SetNewPasswordController());

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
//                 'Set New Password',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.blackButtoncolor,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'Enter your new password.',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: AppColors.blackButtoncolor,
//                 ),
//               ),
//               const SizedBox(height: 30),
//               CommonTextField(
//                 controller: controller.newPasswordController,
//                 hintText: "New Password",
//                 prefixIcon: Icons.lock_outline,
//                 keyboardType: TextInputType.visiblePassword,
//                 togglePassword: true,
//                 isTextHidden: controller.isNewPasswordHidden.value,
//                 toggleIcon: controller.isNewPasswordHidden.value
//                     ? Icons.visibility_off
//                     : Icons.visibility,
//                 toggleFunction: controller.toggleNewPasswordVisibility,
//               ),
//               const SizedBox(height: 20),
//               CommonTextField(
//                 controller: controller.confirmPasswordController,
//                 hintText: "Confirm Password",
//                 prefixIcon: Icons.lock_outline,
//                 keyboardType: TextInputType.visiblePassword,
//                 togglePassword: true,
//                 isTextHidden: controller.isConfirmPasswordHidden.value,
//                 toggleIcon: controller.isConfirmPasswordHidden.value
//                     ? Icons.visibility_off
//                     : Icons.visibility,
//                 toggleFunction:
//                 controller.toggleConfirmPasswordVisibility,
//               ),
//               const SizedBox(height: 60),
//               Center(
//                 child: CommonButton(
//                   text: 'Save',
//                   width: 300,
//                   onPressed: controller.saveNewPassword,
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
import 'package:ryd4ride/controller/auth/set_new_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordController>(
      init: ResetPasswordController(),
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: _buildAppBar(),
          body: controller.isLoading
              ? const IsLoading()
              : _buildCenteredScrollableForm(controller),
        );
      },
    );
  }

  /// 🔹 **AppBar Widget**
  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const Text(
        "Reset Password",
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
      ),
      backgroundColor: AppColors.primaryColor,
      elevation: 4,
    );
  }

  /// 🔹 **Centered Scrollable Form**
  Widget _buildCenteredScrollableForm(ResetPasswordController controller) {
    return Center(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 500,
            minHeight: MediaQuery.of(Get.context!).size.height * 0.7,
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildEmailText(controller),
                _buildPasswordFields(controller),
                const SizedBox(height: 40),
                _buildResetButton(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailText(ResetPasswordController controller) {
    return Text(
      "Enter your new password for ${controller.email}",
      textAlign: TextAlign.center,
      style: GoogleFonts.sora(
        fontSize: 16,
        color: AppColors.primaryColor,
      ),
    ).marginOnly(bottom: 30);
  }

  Widget _buildPasswordFields(ResetPasswordController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("New Password"),
        Obx(() => CommonTextField(
              controller: controller.newPasswordController,
              hintText: "Enter your new password",
              isRequired: true,
              prefixIcon: Icons.lock_outline,
              keyboardType: TextInputType.visiblePassword,
              maxlines: 1,
              togglePassword: true,
              validator: (value) => controller.showValidationMessages.value
                  ? controller.validatePassword(value)
                  : null,
              isTextHidden: controller.isPasswordVisible.value,
              toggleIcon: controller.isPasswordVisible.value
                  ? Icons.visibility_off_outlined
                  : Icons.remove_red_eye_outlined,
              toggleFunction: controller.isPasswordVisible.toggle,
            )),
        const SizedBox(height: 20),
        _buildLabel("Confirm New Password"),
        Obx(() => CommonTextField(
              controller: controller.confirmPasswordController,
              hintText: "Re-enter your password",
              isRequired: true,
              prefixIcon: Icons.lock_outline,
              keyboardType: TextInputType.visiblePassword,
              maxlines: 1,
              togglePassword: true,
              validator: (value) => controller.showValidationMessages.value
                  ? controller.validateConfirmPassword(value)
                  : null,
              isTextHidden: controller.isConfirmPasswordVisible.value,
              toggleIcon: controller.isConfirmPasswordVisible.value
                  ? Icons.visibility_off_outlined
                  : Icons.remove_red_eye_outlined,
              toggleFunction: controller.isConfirmPasswordVisible.toggle,
            )),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return MyText(
      text: text,
      fontFamily: "Outfit",
      fontWeight: FontWeight.w500,
      color: AppColors.primaryColor,
    ).marginOnly(bottom: 10);
  }

  Widget _buildResetButton(ResetPasswordController controller) {
    return Center(
      child: CommonButton(
        text: "Reset Password",
        onPressed: controller.resetPassword,
      ),
    );
  }
}
