import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/routing/app_routes.dart';

class SplashController extends GetxController {
  bool isLoading = true;
  final storage = GetStorage();
  @override
  void onReady() {
    navigatetohome();
    isLoading = false;
    update();
    super.onReady();
  }

  Future<void> navigatetohome() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.onBoard);
      // if (storage.hasData('onBoard')) {
      //   Get.offAllNamed(AppRoutes.login);
      // } else {
      //   Get.offAllNamed(AppRoutes.onBoard);
      // }
    });
  }
}
