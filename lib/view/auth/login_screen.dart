// import 'package:ryd4ride/constants/libraries/app_libraries.dart';
// import 'package:ryd4ride/controller/auth/login_controller.dart';
// import 'package:ryd4ride/routing/app_routes.dart';
// import 'package:ryd4ride/widgets/common_toast.dart';

// import 'forget_password_screen.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: true, // Adjust content when keyboard appears
//       body: SafeArea(child: bodyData(context)),
//     );
//   }

//   Widget bodyData(BuildContext context) {
//     return GetBuilder<LoginController>(
//         init: LoginController(),
//         builder: (_) {
//           return Form(
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             key: _.formKey,
//             child: SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minHeight: Get.height, // Ensure the content expands
//                 ),
//                 child: IntrinsicHeight(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 40), // Top Padding
//                         Center(
//                           child: Image.asset(
//                             AppAssets.appLogo,
//                             width: 200,
//                           ),
//                         ),
//                         const SizedBox(height: 40),
//                         const MyText(
//                           text: 'Login',
//                           fontFamily: 'Roboto',
//                           fontSize: 28,
//                           color: AppColors.blackButtoncolor,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         const SizedBox(height: 10),
//                         const MyText(
//                           text:
//                               'Drive smart, earn more, save RDY4Ride as favorite! & recommend this app to other drivers',
//                           fontFamily: 'Outfit',
//                           color: AppColors.blackButtoncolor,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         const SizedBox(height: 30),
//                         const MyText(
//                           text: "Enter Email",
//                           fontFamily: "Outfit",
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.blackButtoncolor,
//                         ),
//                         CommonTextField(
//                           controller: _.emailOrPhoneController,
//                           inputFormatters: [
//                             EmailOrNumberInputFormatter(
//                                 isEmail: _.isEmailShown == 1),
//                           ],
//                           hintText: _.isEmailShown == 1
//                               ? "Enter your Email"
//                               : "Enter Your Phone",
//                           isRequired: false,
//                           toggleIcon: _.isEmailShown == 1
//                               ? Icons.email_outlined
//                               : Icons.phone,
//                           keyboardType: TextInputType.emailAddress,
//                           validator: (value) {
//                             if (_.isEmailShown == 1) {
//                               if (value!.isEmpty) {
//                                 return "Enter email";
//                               }
//                               Pattern pattern =
//                                   r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                               var regex = RegExp(pattern as String);
//                               return (!regex.hasMatch(value))
//                                   ? 'Please enter valid email'
//                                   : null;
//                             } else {
//                               if (value!.length < 5) {
//                                 return "Should Be a Valid Phone Number";
//                               }
//                               return null;
//                             }
//                           },
//                         ).marginOnly(top: 10, bottom: 20),
//                         const MyText(
//                           text: "Enter Password",
//                           fontFamily: "Outfit",
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.blackButtoncolor,
//                         ).marginOnly(bottom: 10),
//                         CommonTextField(
//                           controller: _.passwordController,
//                           hintText: "Enter your password",
//                           isRequired: false,
//                           keyboardType: TextInputType.visiblePassword,
//                           maxlines: 1,
//                           togglePassword: true,
//                           validator: (value) {
//                             if (value!.length < 8) {
//                               return "Password Length should be at least 8 character";
//                             }
//                             return null;
//                           },
//                           isTextHidden: _.passwordshown,
//                           toggleIcon: _.passwordshown == true
//                               ? Icons.visibility_off_outlined
//                               : Icons.remove_red_eye_outlined,
//                           toggleFunction: () {
//                             _.passwordshown = !_.passwordshown;
//                             _.update();
//                           },
//                         ),
//                         Align(
//                           alignment: Alignment.bottomRight,
//                           child: GestureDetector(
//                             onTap: () {
//                               // Get.offAllNamed(AppRoutes.forgetPassword);
//                               newforget_password();
//                             },
//                             child: const MyText(
//                               text: "Forget Password?",
//                               fontSize: 15,
//                               fontFamily: "Outfit",
//                               fontWeight: FontWeight.w500,
//                               color: AppColors.textfieldColor,
//                             ),
//                           ),
//                         ).marginOnly(top: 10),
//                         Align(
//                             alignment: Alignment.bottomRight,
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 const MyText(
//                                   text: "Stay login",
//                                   fontSize: 15,
//                                   fontFamily: "Outfit",
//                                   fontWeight: FontWeight.w500,
//                                   color: AppColors.textfieldColor,
//                                 ),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 SizedBox(
//                                     height: 24,
//                                     width: 24,
//                                     child: Obx(() => Checkbox(
//                                           fillColor: WidgetStatePropertyAll(
//                                               _.checkbox.value
//                                                   ? AppColors.primaryColor
//                                                   : Colors.white),
//                                           value: _.checkbox.value,
//                                           onChanged: (value) {
//                                             _.checkbox.value = value ?? false;
//                                           },
//                                         )))
//                               ],
//                             )).marginOnly(top: 10),
//                         // const SizedBox(height: 20),
//                         Center(
//                           child: CommonButton(
//                             width: Get.width - 60,
//                             text: 'Sign In',
//                             onPressed: () {
//                               if (_.validateForm()) {
//                                 Get.offAllNamed(AppRoutes.maps);
//                               } else {
//                                 Get.snackbar("Error", "Fill all fields");
//                                 // CommonSnackBar.showSnackBar(
//                                 //     // isWarning: true,
//                                 //     title: "Fill all fields");
//                               }
//                             },
//                           ),
//                         ).marginOnly(top: 40),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Align(
//                           alignment: Alignment.bottomCenter,
//                           child: TextButton(
//                               onPressed: () {
//                                 Get.offAllNamed(AppRoutes.maps);
//                               },
//                               child: const Text(
//                                 "Guest Sign In",
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     color: AppColors.primaryColor,
//                                     fontWeight: FontWeight.bold),
//                               )),
//                         ),
//                         _buildDivider(),
//                         _buildSocialLoginButtons(),
//                         // const Spacer(),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Center(
//                           child: Text.rich(
//                             TextSpan(
//                               text: "Don't have an account? ",
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 color: AppColors.primaryColor,
//                               ),
//                               children: <InlineSpan>[
//                                 TextSpan(
//                                   text: 'Create Account',
//                                   recognizer: TapGestureRecognizer()
//                                     ..onTap = () {
//                                       Get.toNamed(AppRoutes.register);
//                                     },
//                                   style: const TextStyle(
//                                     decoration: TextDecoration.underline,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     color: AppColors.primaryColor,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ).marginOnly(bottom: 20),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         });
//   }

//   Widget _buildDivider() {
//     return const Row(
//       children: [
//         Expanded(
//           child: Divider(
//             color: AppColors.primaryColor,
//             thickness: 1,
//             indent: 30,
//             endIndent: 10,
//           ),
//         ),
//         Text(
//           "OR",
//           style: TextStyle(
//             color: AppColors.primaryColor,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Expanded(
//           child: Divider(
//             color: AppColors.primaryColor,
//             thickness: 1,
//             indent: 10,
//             endIndent: 30,
//           ),
//         ),
//       ],
//     ).marginSymmetric(vertical: 10);
//   }

//   Widget _buildSocialLoginButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         CircleAvatar(
//           maxRadius: 30,
//           backgroundColor: AppColors.primaryColor,
//           child: Center(
//             child: IconButton(
//               onPressed: () {},
//               icon: Image.asset(
//                 AppAssets.googlelogo,
//                 width: 25,
//               ),
//               color: AppColors.blackButtoncolor,
//             ),
//           ),
//         ).marginOnly(right: 20),
//         CircleAvatar(
//           maxRadius: 30,
//           backgroundColor: AppColors.primaryColor,
//           child: Center(
//             child: IconButton(
//               onPressed: () {},
//               icon: const Icon(
//                 Icons.apple,
//                 size: 30,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/controller/auth/login_controller.dart';
import 'package:ryd4ride/routing/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return controller.isLoading
              ? IsLoading()
              : _buildLoginForm(controller);
        });
  }

  Widget _buildLoginForm(LoginController controller) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: controller.formKey,
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: Get.height,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  _buildLogo(),
                  const SizedBox(height: 40),
                  _buildHeader(),
                  const SizedBox(height: 30),
                  _buildEmailField(controller),
                  _buildPasswordField(controller),
                  _buildForgotPasswordAndStayLogin(controller),
                  _buildSignInButton(controller),
                  _buildGuestLogin(),
                  _buildDivider(),
                  _buildSocialLoginButtons(),
                  const SizedBox(height: 20),
                  _buildCreateAccountLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Image.asset(
        AppAssets.appLogo,
        width: 200,
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: 'Login',
          fontFamily: 'Roboto',
          fontSize: 28,
          color: AppColors.blackButtoncolor,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 10),
        MyText(
          text:
              'Drive smart, earn more, save RDY4Ride as favorite! & recommend this app to other drivers',
          fontFamily: 'Outfit',
          color: AppColors.blackButtoncolor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget _buildEmailField(LoginController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MyText(
          text: "Enter Email",
          fontFamily: "Outfit",
          fontWeight: FontWeight.w500,
          color: AppColors.blackButtoncolor,
        ),
        CommonTextField(
          controller: controller.emailOrPhoneController,
          // inputFormatters: [
          //   EmailOrNumberInputFormatter(
          //       isEmail: controller.isEmailShown.value == 1),
          // ],
          hintText: "Enter Your Email",
          prefixIcon: Icons.email,
          isRequired: false,
          // toggleIcon: controller.isEmailShown.value == 1
          //     ? Icons.email_outlined
          //     : Icons.phone,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            controller.validateEmail(value);
            return null;
            // if (controller.isEmailShown.value == 1) {

            // } else {
            //   return controller.validatePhone(value);
            // }
          },
        ).marginOnly(top: 10, bottom: 20),
      ],
    );
  }

  Widget _buildPasswordField(LoginController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MyText(
          text: "Enter Password",
          fontFamily: "Outfit",
          fontWeight: FontWeight.w500,
          color: AppColors.blackButtoncolor,
        ).marginOnly(bottom: 10),
        Obx(() => CommonTextField(
              controller: controller.passwordController,
              hintText: "Enter your password",
              isRequired: false,
              keyboardType: TextInputType.visiblePassword,
              maxlines: 1,
              togglePassword: true,
              prefixIcon: Icons.lock,
              validator: controller.validatePassword,
              isTextHidden: controller.passwordshown.value,
              toggleIcon: controller.passwordshown.value
                  ? Icons.visibility_off_outlined
                  : Icons.remove_red_eye_outlined,
              toggleFunction: controller.togglePasswordVisibility,
            )),
      ],
    );
  }

  Widget _buildForgotPasswordAndStayLogin(LoginController controller) {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.forgetPassword);
            },
            child: const MyText(
              text: "Forget Password?",
              fontSize: 15,
              fontFamily: "Outfit",
              fontWeight: FontWeight.w500,
              color: AppColors.textfieldColor,
            ),
          ),
        ).marginOnly(top: 10),
        Align(
          alignment: Alignment.bottomRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const MyText(
                text: "Stay login",
                fontSize: 15,
                fontFamily: "Outfit",
                fontWeight: FontWeight.w500,
                color: AppColors.textfieldColor,
              ),
              const SizedBox(width: 10),
              SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    fillColor: WidgetStatePropertyAll(controller.checkbox
                        ? AppColors.primaryColor
                        : Colors.white),
                    value: controller.checkbox,
                    onChanged: (value) {
                      controller.checkbox = value ?? false;
                      controller.update();
                    },
                  ))
            ],
          ),
        ).marginOnly(top: 10),
      ],
    );
  }

  Widget _buildSignInButton(LoginController controller) {
    return Center(
      child: CommonButton(
        width: Get.width - 60,
        text: 'Sign In',
        onPressed: () async {
          await controller.loginUser();
        },
      ),
    ).marginOnly(top: 40);
  }

  Widget _buildGuestLogin() {
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
                fontWeight: FontWeight.bold),
          )),
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

  Widget _buildCreateAccountLink() {
    return Center(
      child: Text.rich(
        TextSpan(
          text: "Don't have an account? ",
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.primaryColor,
          ),
          children: <InlineSpan>[
            TextSpan(
              text: 'Create Account',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.toNamed(AppRoutes.register);
                },
              style: const TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            )
          ],
        ),
      ),
    ).marginOnly(bottom: 20);
  }
}
