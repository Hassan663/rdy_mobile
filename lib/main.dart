import 'package:flutter/services.dart';
import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/routing/app_pages.dart';
import 'package:ryd4ride/view/menu/maps_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<ApiService>(() => ApiService());
  //await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class NoGlowBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // AppBindings.dependencies();
    return GetMaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: NoGlowBehavior(),
          child: child!,
        );
      },
      // title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.blueAccent),
        hintColor: Colors.black,
        primaryColorLight: AppColors.primaryColor,
        primaryColorDark: AppColors.primaryColor,
        primaryColor: AppColors.primaryColor,
      ),
      defaultTransition: Get.defaultTransition,
      supportedLocales: const [Locale("en", "US")],
      // home: MapScreen(),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
