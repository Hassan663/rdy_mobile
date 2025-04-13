
import 'package:ryd4ride/constants/libraries/app_libraries.dart';

// // ignore: must_be_immutable
class CommonContainerWithOutContent extends StatelessWidget {
  final Widget content;
  final Color? bgColor;

  const CommonContainerWithOutContent(
      {Key? key, required this.content, this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
        color: bgColor ?? const Color(0xfff0f0f0),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: content,
    );
  }
}

class CommonCircularContainer extends StatelessWidget {
  final Widget content;

  const CommonCircularContainer({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 150,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
        color: const Color(0xfff0f0f0),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: content,
    );
  }
}

class CommonContainer extends StatelessWidget {
  final String heading;
  final Widget? trailingWidget;
  final Widget content;
  final Color? headingColor;
  final Color? bgColor;

  const CommonContainer({
    super.key,
    required this.heading,
    this.trailingWidget,
    this.headingColor,
    this.bgColor,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 14,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
        color: bgColor ?? const Color(0xffF6F6F6).withOpacity(0.9),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  heading,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: headingColor ?? AppColors.blackButtoncolor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: trailingWidget,
              )
            ],
          ),
          content.marginSymmetric(vertical: 10),
        ],
      ).marginSymmetric(horizontal: 20, vertical: 15),
    ).marginSymmetric(vertical: 10, horizontal: 20);
  }
}