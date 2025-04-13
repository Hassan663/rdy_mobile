// import 'dart:ui';
// import 'package:ryd4ride/constants/libraries/app_libraries.dart';
// import 'package:ryd4ride/controller/auth/forget_password_controller.dart';
// import 'package:ryd4ride/routing/app_routes.dart';
// import 'package:ryd4ride/view/auth/verify_otp_screen.dart';

// class ForgotPasswordScreen extends StatelessWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primaryColor,
//       resizeToAvoidBottomInset:
//           false, // Enable resizing when the keyboard is open
//       body: bodyData(context),
//     );
//   }

//   Widget bodyData(BuildContext context) {
//     final double containerHeight = MediaQuery.of(context).size.height * 0.6;

//     return GetBuilder<ForgotPasswordController>(
//       init: ForgotPasswordController(),
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
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       spreadRadius: 5,
//                       blurRadius: 10,
//                     ),
//                   ],
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
//                         'Please enter your registered email address. We will send an OTP to reset your password.',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: AppColors.blackButtoncolor,
//                         ),
//                       ),
//                       const SizedBox(height: 60),
//                       const Text(
//                         "Enter Email",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.blackButtoncolor,
//                         ),
//                       ),
//                       CommonTextField(
//                         controller: controller.emailController,
//                         hintText: "Enter your Email",
//                         prefixIcon: Icons.email_outlined,
//                         keyboardType: TextInputType.emailAddress,

//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Enter email";
//                           }
//                           String pattern =
//                               r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                           RegExp regex = RegExp(pattern);
//                           return (!regex.hasMatch(value))
//                               ? 'Please enter a valid email'
//                               : null;
//                         },
//                       ).marginOnly(top: 10, bottom: 60),
//                       Center(
//                         child: CommonButton(
//                           // width: double.infinity,
//                           text: 'Send OTP',
//                           width: 300,
//                           onPressed: () {
//                             Get.toNamed(AppRoutes.verifyotp);
//                           },
//                         ),
//                       ),
//                       Center(
//                         child: CommonButton(
//                           // width: double.infinity,
//                           text: 'Back to Login',
//                           width: 300,
//                           onPressed: () {
//                             Get.offAllNamed(AppRoutes.login);
//                           },
//                         ),
//                       ).marginSymmetric(vertical: 20),
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

// newforget_password(){
//   final controller=Get.put(ForgotPasswordController());

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
//                   color: Colors.grey,
//                     borderRadius: BorderRadius.circular(20)
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
//                 'Enter Your Register Email',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: AppColors.blackButtoncolor,
//                 ),
//               ),
//               const SizedBox(height: 60),
//               const Text(
//                 "Enter Email",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: AppColors.blackButtoncolor,
//                 ),
//               ),
//               CommonTextField(
//                 radius: 50,
//                 controller: controller.emailController,
//                 hintText: "Enter your Email",
//                 prefixIcon: Icons.email_outlined,
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return "Enter email";
//                   }
//                   String pattern =
//                       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                   RegExp regex = RegExp(pattern);
//                   return (!regex.hasMatch(value))
//                       ? 'Please enter a valid email'
//                       : null;
//                 },
//               ).marginOnly(top: 10, bottom: 60),
//               Center(
//                 child: CommonButton(
//                   text: 'Send OTP',
//                   width: Get.width-50,
//                   onPressed: () {
//                     // Get.toNamed(AppRoutes.verifyotp);
//                     newverify_otp();
//                   },
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
import 'package:ryd4ride/controller/auth/forget_password_controller.dart';
import 'package:ryd4ride/routing/app_routes.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed(AppRoutes.login);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: GetBuilder<ForgotPasswordController>(
        init: ForgotPasswordController(),
        builder: (controller) {
          return controller.isLoading
              ? const Center(child: IsLoading())
              : _buildForgotPasswordForm(controller);
        },
      ),
    );
  }

  /// 🔹 **Forgot Password Form**
  Widget _buildForgotPasswordForm(ForgotPasswordController controller) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 500,
          minHeight: MediaQuery.of(Get.context!).size.height * 0.7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo(),
            _buildHeaderText(),
            const SizedBox(height: 20),
            _buildTextFieldLabel("Email"),
            _buildEmailField(controller),
            const SizedBox(height: 30),
            _buildResetButton(controller),
          ],
        ),
      ),
    );
  }

  /// 🔹 **App Logo**
  Widget _buildLogo() {
    return Center(
      child: Image.asset(
        AppAssets.appLogo,
        width: 120,
      ),
    ).marginOnly(bottom: 40);
  }

  /// 🔹 **Header Text**
  Widget _buildHeaderText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MyText(
          text: "Forgot Password",
          fontFamily: "Poppins",
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
        MyText(
          text: "Enter your Phone Number to receive a password reset code.",
          fontFamily: "Sora",
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.blackColor30,
        ).marginOnly(top: 10, bottom: 10),
      ],
    );
  }

  Widget _buildTextFieldLabel(String text) {
    return MyText(
      text: text,
      fontFamily: "Outfit",
      fontWeight: FontWeight.w500,
      color: AppColors.primaryColor,
    ).marginOnly(bottom: 10);
  }

  Widget _buildEmailField(ForgotPasswordController controller) {
    return CommonTextField(
      controller: controller.emailController,
      hintText: "Enter your Email",
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icons.email_outlined,
      validator: (value) => controller.showValidationMessages.value
          ? controller.validateEmail(value)
          : null,
    ).marginOnly(bottom: 20);
  }

  Widget _buildResetButton(ForgotPasswordController controller) {
    return Center(
      child: CommonButton(
        text: "Send Reset Code",
        onPressed: () async {
          await controller.sendResetLink();
        },
      ),
    );
  }
}
