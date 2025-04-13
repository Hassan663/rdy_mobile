
import 'package:ryd4ride/constants/libraries/app_libraries.dart';

class MyText extends StatelessWidget {
  final String? text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final String fontFamily;
  final FontStyle? fontStyle;
  final TextDecoration? textDecoration;
  final double? letterSpacing;
  final double? wordSpacing;

  const MyText({
    super.key,
    required this.text,
    this.fontWeight,
    this.fontSize,
    this.color,
    required this.fontFamily,
    this.fontStyle,
    this.textDecoration,
    this.letterSpacing,
    this.wordSpacing,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle style = GoogleFonts.getFont(
      fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      fontStyle: fontStyle,
      decoration: textDecoration,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
    );

    return Text(
      text!,
      style: style,
      // textAlign: TextAlign.center,
    );
  }
}