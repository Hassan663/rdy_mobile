import 'package:ryd4ride/constants/libraries/app_libraries.dart';

class CommonSnackBar {
  static void showSnackBar({
    required String title,
    bool isWarning = false,
    String? imageUrl,
  }) {
    Get.snackbar(
      isWarning ? 'Error' : 'Success',
      title,
      snackPosition: SnackPosition.TOP,
      backgroundColor: isWarning ? Colors.red : AppColors.primaryColor,
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      snackStyle: SnackStyle.FLOATING,
      backgroundGradient: LinearGradient(
        colors: [
          isWarning ? Colors.red : AppColors.primaryColor,
          isWarning ? Colors.redAccent : Colors.blueAccent,
        ],
      ),
    );
  }
}

class CommonToast {
  static void showToast({
    required String title,
    bool isWarning = false,
  }) {
    Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      // timeInSecForIosWeb: 1,
      backgroundColor:
          isWarning == true ? Colors.redAccent : AppColors.primaryColor,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}

// void showMotionToast({
//   required ToastType type,
//   required BuildContext context,
//   required String description,
//   IconData? icon,
//   Color? primaryColor,
//   double? width,
//   double? height,
// }) {
//   switch (type) {
//     case ToastType.success:
//       MotionToast.success(
//         title: const MyText(
//           text: "Success",
//           fontFamily: "Roboto",
//           fontWeight: FontWeight.bold,
//         ),
//         description: Text(description),
//       ).show(context);
//       break;
//     case ToastType.warning:
//       MotionToast.warning(
//         title: const MyText(
//           text: "Warning",
//           fontFamily: "Roboto",
//           fontWeight: FontWeight.bold,
//         ),
//         description: Text(description),
//       ).show(context);
//       break;
//     case ToastType.error:
//       MotionToast.error(
//         title: const MyText(
//           text: "Error",
//           fontFamily: "Roboto",
//           fontWeight: FontWeight.bold,
//         ),
//         description: Text(description),
//       ).show(context);
//       break;
//     case ToastType.info:
//       MotionToast.info(
//         title: const MyText(
//           text: "Info",
//           fontFamily: "Roboto",
//           fontWeight: FontWeight.bold,
//         ),
//         description: Text(description),
//       ).show(context);
//       break;
//     case ToastType.delete:
//       MotionToast.delete(
//         title: const MyText(
//           text: "Deleted",
//           fontFamily: "Roboto",
//           fontWeight: FontWeight.bold,
//         ),
//         description: Text(description),
//       ).show(context);
//       break;
//     case ToastType.custom:
//       MotionToast(
//         icon: icon ?? Icons.info,
//         primaryColor: primaryColor ?? Colors.grey,
//         title: const Text("Info"),
//         description: Text(description),
//         width: width ?? 300,
//         height: height ?? 100,
//       ).show(context);
//       break;
//   }
// }

enum ToastType {
  success,
  error,
  warning,
  info,
  delete,
  custom,
}
