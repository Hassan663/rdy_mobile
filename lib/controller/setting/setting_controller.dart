import 'package:ryd4ride/constants/libraries/app_libraries.dart';

class SettingController extends GetxController {
  bool isLoading = true;
  @override
  void onReady() {
    isLoading = false;
    update();
    super.onReady();
  }

}
