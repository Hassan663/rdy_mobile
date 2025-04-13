// widgets/common_app_bar.dart
import 'package:flutter/material.dart';
import 'package:ryd4ride/constants/libraries/app_libraries.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onLeadingPressed;
  final VoidCallback onTrailingPressed;

  CommonAppBar({
    required this.title,
    required this.onLeadingPressed,
    required this.onTrailingPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: onLeadingPressed,
      ),
      centerTitle: true,
      title: Image.asset(
        AppAssets.appLogo,
        color: Colors.white,
        height: 60,
        width: 100,
      ), // Replace with actual logo path
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          onPressed: onTrailingPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
