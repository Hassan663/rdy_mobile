
import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/routing/app_routes.dart';

class MenuBottomSheet {
  static void showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              _buildMenuItem(
                icon: Icons.notifications_outlined,
                text: "Notifications",
                onTap: () {
                  Get.back();
                  // Navigate to Notifications
                  Get.toNamed(AppRoutes.notifications);
                },
              ),
              _divider(),
              _buildMenuItem(
                icon: Icons.inventory_2_outlined,
                text: "Subscription ",
                onTap: () {
                  Get.back();
                  // Navigate to Packages
                  Get.toNamed(AppRoutes.subscriptionPackages);
                },
              ),
              _divider(),
              _buildMenuItem(
                icon: Icons.settings_outlined,
                text: "Settings",
                onTap: () {
                  Get.back();
                  // Navigate to Settings
                  Get.toNamed(AppRoutes.setting);
                },
              ),
              _divider(),
              _buildMenuItem(
                icon: Icons.logout,
                text: "Logout",
                textColor: Colors.red,
                iconColor: Colors.red,
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.login);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildMenuItem({
    required IconData icon,
    required String text,
    Color iconColor = Colors.black,
    Color textColor = Colors.black,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        text,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  static Widget _divider() {
    return const Divider(
      thickness: 1,
      color: Colors.grey,
    );
  }
}

// Usage in your main screen:
// Call this function in the onPressed callback of your menu icon
// MenuBottomSheet.showMenu(context);