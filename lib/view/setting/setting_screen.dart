import 'package:ryd4ride/controller/setting/setting_controller.dart';
import 'package:ryd4ride/routing/app_routes.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:ryd4ride/constants/libraries/app_libraries.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double avatarRadius = 50;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<SettingController>(
            init: SettingController(),
            builder: (_) {
              return Column(
                children: <Widget>[
                  Stack(
                    clipBehavior: Clip.none, // Allow overflow of the child widget
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        color: AppColors.primaryColor,
                        height: 250 -
                            avatarRadius +
                            10, // Adjust height to match the design
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 40, bottom: avatarRadius),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GradientText(
                              "RYD4RIDE",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                              colors: const [
                                Colors.blueAccent,
                                AppColors.whitecolor,
                                AppColors.lightgreyColor,
                                Colors.blueAccent,
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: -avatarRadius,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 60,
                          child: Center(
                              child: Image.asset(
                            AppAssets.appLogo,
                            // width: 80,
                            // height: 100,
                            fit: BoxFit.fill,
                          )).marginAll(6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  // Container(
                  //   height: 50,
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 12.0, vertical: 10.0),
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: AppColors.secondaryColor),
                  //     borderRadius: BorderRadius.circular(8.0),
                  //   ),
                  //   child: Center(
                  //     child: RichText(
                  //       overflow: TextOverflow.ellipsis,
                  //       text: TextSpan(
                  //         children: [
                  //           TextSpan(
                  //             text: "Account ", // This will be bold
                  //             style: TextStyle(
                  //               fontWeight: FontWeight.w500,
                  //               color: AppColors
                  //                   .primaryColor, // Set the color as needed
                  //               fontSize: 16, // Adjust font size as needed
                  //             ),
                  //           ),
                  //           TextSpan(
                  //             text: "(${_.publicKey})", // This will be normal
                  //             style: TextStyle(
                  //               fontWeight: FontWeight.normal,
                  //               color: Colors.black, // Set the color as needed
                  //               fontSize: 16, // Adjust font size as needed
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ).marginSymmetric(horizontal: 20, vertical: 10),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(
                          top: 30, left: 10, right: 10), // Offset the list start
                      children: ListTile.divideTiles(
                        color: Colors.white,
                        tiles: [
                          _customListTile(
                              Icons.account_circle_outlined, "Profile", () {
                            Get.toNamed(AppRoutes.editProfile);
                          }),
                          _customListTile(
                              Icons.notifications_outlined, "Notifications", () {
                            Get.toNamed(AppRoutes.notifications);
                          }),
                          _customListTile(
                              Icons.favorite_outline, "Favourite Events", () {
                            Get.toNamed(AppRoutes.favouriteEvents);
                          }),
                          _customListTile(Icons.loyalty_outlined, "Subscription",
                              () {
                            Get.toNamed(AppRoutes.subscriptionPackages);
                          }),
                          _customListTile(Icons.credit_card_outlined, "Add Card",
                              () {
                            Get.toNamed(AppRoutes.addCard);
                          }),
                          _customListTile(Icons.password, "Change Password", () {
                             Get.toNamed(AppRoutes.changepassword);
                          }),
                          _customListTile(Icons.help_outline, "Help & Support",
                              () {
                             Get.toNamed(AppRoutes.help);
                          }),
                          _customListTile(Icons.info_outline, "OnBoard Tutorials",
                              () {
                            Get.toNamed(AppRoutes.onBoardTutorial);
                          }),
                          _customListTile(
                              Icons.star_border_outlined, "Rate Our App", () {
                            // Get.toNamed(AppRoutes.transaction);
                          }),
                          _customListTile(Icons.lock, "Logout", () {
                            Get.offAllNamed(AppRoutes.login);
                          }),
                        ],
                      ).toList(),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget _customListTile(
      IconData icon, String title, GestureTapCallback? onPresed) {
    return GestureDetector(
      onTap: onPresed,
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
        child: ListTile(
            leading: Icon(icon, color: AppColors.primaryColor)
                .marginOnly(right: 10, left: 10),
            title: MyText(
              text: title,
              fontFamily: "Outfit",
              fontWeight: FontWeight.w500,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            trailing: const Icon(Icons.arrow_forward_ios,
                color: AppColors.primaryColor),
            onTap: onPresed),
      ),
    );
  }
}
