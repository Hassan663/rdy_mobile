import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/controller/setting/onboard_tutorial_controller.dart';
import 'package:ryd4ride/controller/splash/onboard_controller.dart';
import 'package:ryd4ride/routing/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: bodyData(context),
    );
  }

  // ------------------------------------------------ MAIN WIDGET -------------------------------------------------

  Widget bodyData(BuildContext context) {
    return GetBuilder<OnBoardController>(
      init: OnBoardController(),
      builder: (_) {
        return _.isLoading
            ? const IsLoading()
            : SafeArea(
              child: Center(
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 30,),
                          Image.asset(
                            _.cards[0].imageUrl,
                            fit: BoxFit.contain,
                            height: 250,
                          ),
                          const SizedBox(height: 50),
                          Text(
                            _.cards[0].title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: AppColors.primaryColor,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            _.cards[0].description,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: AppColors.primaryColor,
                              fontSize: 14.0,
                            ),
                          ),
                          // Expanded(
                          //   child: PageView.builder(
                          //     controller: _.pageController,
                          //     onPageChanged: _.onPageChanged,
                          //     itemCount: _.cards.length,
                          //     itemBuilder: (context, index) {
                          //       return Column(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: <Widget>[
                          //
                          //         ],
                          //       );
                          //     },
                          //   ),
                          // ),
                          // Obx(
                          //   () => Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: List<Widget>.generate(
                          //       _.cards.length,
                          //       (int index) {
                          //         return AnimatedContainer(
                          //           duration: const Duration(milliseconds: 300),
                          //           height: 10,
                          //           width: 10,
                          //           margin: const EdgeInsets.symmetric(
                          //               vertical: 10.0, horizontal: 5.0),
                          //           decoration: BoxDecoration(
                          //               shape: BoxShape.circle,
                          //               color: _.currentPage.value == index
                          //                   ? AppColors.primaryColor
                          //                   : Colors.grey.withOpacity(0.5)),
                          //         );
                          //       },
                          //     ),
                          //   ),
                          // ),
                          SlideToSkipButton().marginOnly(bottom: 40, top: 60)
                          // GestureDetector(
                          //   onHorizontalDragUpdate: (details) {
                          //     if (details.delta.dx > 10) {
                          //       // If swiped sufficiently to the right
                          //       Get.offAllNamed(AppRoutes.login); // Navigate to login
                          //     }
                          //   },
                          //   child: Container(
                          //     margin: const EdgeInsets.only(bottom: 30),
                          //     padding: const EdgeInsets.symmetric(
                          //         horizontal: 30, vertical: 15),
                          //     decoration: BoxDecoration(
                          //       color: AppColors.primaryColor,
                          //       borderRadius: BorderRadius.circular(30),
                          //       boxShadow: [
                          //         BoxShadow(
                          //           color: Colors.black.withOpacity(0.1),
                          //           blurRadius: 10,
                          //           offset: const Offset(0, 5),
                          //         ),
                          //       ],
                          //     ),
                          //     child: Row(
                          //       mainAxisSize: MainAxisSize.min,
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         const Icon(
                          //           Icons.arrow_forward,
                          //           color: Colors.white,
                          //         ),
                          //         const SizedBox(width: 10),
                          //         Text(
                          //           "Slide To Skip",
                          //           style: GoogleFonts.poppins(
                          //             fontSize: 16,
                          //             color: Colors.white,
                          //             fontWeight: FontWeight.bold,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
              ),
            );
      },
    );
  }
}

class SlideToSkipButton extends StatefulWidget {
  @override
  _SlideToSkipButtonState createState() => _SlideToSkipButtonState();
}

class _SlideToSkipButtonState extends State<SlideToSkipButton>
    with SingleTickerProviderStateMixin {
  double dragPosition = 0.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        setState(() {
          dragPosition = _controller.value;
        });
      });
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      dragPosition += details.primaryDelta!;
      dragPosition = dragPosition.clamp(0.0, MediaQuery.of(context).size.width - 100);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (dragPosition > MediaQuery.of(context).size.width - 140) {
      // Navigate to login if fully dragged to the right
      Get.offAllNamed(AppRoutes.login);
    } else {
      // Snap back if not dragged enough
      _controller.reverse(from: dragPosition / (MediaQuery.of(context).size.width - 100));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background progress indicator
          Container(
            width: dragPosition,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Center(
            child: Text(
              "Slide to Skip",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            left: dragPosition,
            child: GestureDetector(
              onHorizontalDragUpdate: _onDragUpdate,
              onHorizontalDragEnd: _onDragEnd,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}