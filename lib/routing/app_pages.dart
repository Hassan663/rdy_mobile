import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/routing/app_routes.dart';
import 'package:ryd4ride/view/auth/forget_password_screen.dart';
import 'package:ryd4ride/view/auth/login_screen.dart';
import 'package:ryd4ride/view/auth/register_screen.dart';
import 'package:ryd4ride/view/auth/set_new_password_screen.dart';
import 'package:ryd4ride/view/auth/verify_otp_screen.dart';
import 'package:ryd4ride/view/menu/events_page.dart';
import 'package:ryd4ride/view/menu/maps_screen.dart';
import 'package:ryd4ride/view/setting/add_card_screen.dart';
import 'package:ryd4ride/view/setting/change_password_screen.dart';
import 'package:ryd4ride/view/setting/favourite_events_screen.dart';
import 'package:ryd4ride/view/setting/help_screen.dart';
import 'package:ryd4ride/view/setting/notifications_screen.dart';
import 'package:ryd4ride/view/setting/onboard_tutorial_screen.dart';
import 'package:ryd4ride/view/setting/profile_screen.dart';
import 'package:ryd4ride/view/setting/setting_screen.dart';
import 'package:ryd4ride/view/splash/onboard_screen.dart';
import 'package:ryd4ride/view/splash/splash_screen.dart';
import 'package:ryd4ride/view/subscription/subscription_packages_screen.dart';

class AppPages {
  static var initial = AppRoutes.splash;
  static final routes = [
    // <------ Login Routes --------->

    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    // <------ Login Routes --------->

    GetPage(
      name: AppRoutes.onBoard,
      page: () => const OnBoardScreen(),
    ),
    // <------ Login Routes --------->

    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
    ),

    // <------ Forget Password Routes --------->

    GetPage(
      name: AppRoutes.forgetPassword,
      page: () => const ForgotPasswordScreen(),
    ),

    // <------ Register Routes --------->

    GetPage(
      name: AppRoutes.register,
      page: () => RegisterScreen(),
    ),

    // <------ Events Routes --------->

    GetPage(
      name: AppRoutes.events,
      page: () => const EventsScreen(),
    ),

    // <------ SUBS Packages Routes --------->

    GetPage(
      name: AppRoutes.subscriptionPackages,
      page: () => const SubscriptionScreen(),
    ),

    // <------ Setting Routes --------->

    GetPage(
      name: AppRoutes.setting,
      page: () => const SettingScreen(),
    ),

    // <------ Edit Profile Routes --------->

    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditUserDetails(),
    ),

    // <------ Notifications Routes --------->

    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationScreen(),
    ),

    // <------ Fav Events Routes --------->

    GetPage(
      name: AppRoutes.favouriteEvents,
      page: () => const FavouriteEventsScreen(),
    ),

    // <------ Add Cards Routes --------->

    GetPage(
      name: AppRoutes.addCard,
      page: () => const AddCardScreen(),
    ),

    // <------ Onboard Routes --------->

    GetPage(
      name: AppRoutes.onBoardTutorial,
      page: () => const OnBoardtutorialScreen(),
    ),

    // <------ Change Pasword Routes --------->

    GetPage(
      name: AppRoutes.changepassword,
      page: () => const ChangePasswordScreen(),
    ),

    // <------ Help Routes --------->

    GetPage(
      name: AppRoutes.help,
      page: () => HelpScreen(),
    ),

    // <------ Maps Routes --------->

    GetPage(
      name: AppRoutes.maps,
      page: () => const MapScreen(),
    ),

    // <------ OTP Routes --------->

    GetPage(
      name: AppRoutes.verifyotp,
      page: () => const VerifyOtpScreen(),
    ),

    // <------ Maps Routes --------->

    GetPage(
      name: AppRoutes.setnewPassword,
      page: () => const ResetPasswordScreen(),
    ),
  ];
}
