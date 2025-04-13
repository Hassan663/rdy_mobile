import 'package:ryd4ride/constants/libraries/app_libraries.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final void Function() onPressed;
  final Color? color;
  final double? width;
  final double? height;
  final bool isIconShown;
  final IconData? icondata;

  // ignore: use_key_in_widget_constructors
  const CommonButton(
      {required this.text,
      this.textStyle,
      required this.onPressed,
      this.isIconShown = false,
      this.icondata,
      this.color,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return
      AnimatedButton(
      onPressed: onPressed,
      duration: 100,
      width: width ?? 200,
      height: height ?? 50,
      color: color ?? AppColors.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            // ignore: deprecated_member_use
            // textScaleFactor: 1.0,
            style: textStyle ??
                GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
            maxLines: 2,
          ),
          const SizedBox(
            width: 5,
          ),
          isIconShown == true
              ? Icon(
                  icondata,
                  color: Colors.white,
                  size: 20,
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

// ---------------------------------------- Icon Button ----------------------------------------------------

class CommonIcon extends StatelessWidget {
  final IconData iconData;
  final Color? color;
  final double? size;
  final TextDirection? textDirection;
  final String? semanticLabel;
  final bool? isButton;
  final VoidCallback? onPressed;

  const CommonIcon({
    super.key,
    required this.iconData,
    this.color,
    this.size,
    this.textDirection,
    this.semanticLabel,
    this.isButton = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return isButton!
        ? IconButton(
            padding: const EdgeInsets.all(0),
            icon: Icon(
              iconData,
              color: color,
              size: size,
              textDirection: textDirection,
              semanticLabel: semanticLabel,
            ),
            onPressed: onPressed,
          )
        : Icon(
            iconData,
            color: color,
            size: size,
            textDirection: textDirection,
            semanticLabel: semanticLabel,
          );
  }
}

// ------------------------------ GRADIENT BUTTON -----------------------------------

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 200.0,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor:
              Colors.transparent, // Make the button background transparent
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
