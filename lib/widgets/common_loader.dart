

import 'package:ryd4ride/constants/libraries/app_libraries.dart';

// class IsCircularLoading extends StatelessWidget {
//   const IsCircularLoading({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//         child: SpinKitDoubleBounce(
//       color: AppColors.primaryColor,
//     ));
//   }
// }

class IsLoading extends StatelessWidget {
  const IsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator());
  }
}

