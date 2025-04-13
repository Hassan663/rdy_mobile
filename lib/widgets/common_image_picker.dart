
import 'package:ryd4ride/constants/libraries/app_libraries.dart';

class ImagePickerUtils {
  static void showImagePickerModalSheet(
    BuildContext context, {
    required VoidCallback onTapCamera,
    required VoidCallback onTapGallery,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.whitecolor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0)),
          ),
          height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: onTapCamera,
                child: Card(
                  shadowColor: Colors.grey,
                  elevation: 50.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.camera,
                        color: AppColors.primaryColor,
                        size: 40,
                      ),
                      const MyText(
                        text: "Camera",
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ).marginOnly(top: 20)
                    ],
                  ).marginAll(12),
                ).marginAll(12),
              ),
              GestureDetector(
                onTap: onTapGallery,
                child: Card(
                  shadowColor: Colors.grey,
                  elevation: 15.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.photo,
                        color: AppColors.primaryColor,
                        size: 40,
                      ),
                      const MyText(
                        text: " Gallery ",
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ).marginOnly(top: 20)
                    ],
                  ).marginAll(12),
                ).marginAll(12),
              ),
            ],
          ),
        );
      },
    );
  }
}