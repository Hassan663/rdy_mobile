
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:ryd4ride/constants/libraries/app_libraries.dart';

class EditProfileController extends GetxController {
  bool isLoading = true;
  XFile? xImageFile;
  String? imageLink;
  final storage = GetStorage();
  
  // final dashBoardController = Get.find<DashboardController>();
  TextEditingController firstNamecontroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController faceBookController = TextEditingController();
  TextEditingController instaController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  String id = '';
  @override
  void onReady() async {
    
    isLoading = false;
    update();

    super.onReady();
  }

  getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      xImageFile = XFile(pickedFile.path);
      update();
    }
  }

  /// Get from Camera
  getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      xImageFile = XFile(pickedFile.path);
      update();
    }
  }

  Future<XFile> urlToXFile(String imageUrl) async {
    var cacheManager = DefaultCacheManager();
    var file = await cacheManager.getSingleFile(imageUrl);
    return XFile(file.path);
  }

  // // --------------------------------------- Edit Profile Controller ---------------------------------------

  // Future<void> editprofile() async {
  //   isLoading = true;
  //   update();

  //   try {
  //     String token = storage.read('Token');
  //     if (kDebugMode) {
  //       Get.log("URL ${ApiData.baseUrl}${ApiData.user}/$id");
  //     }
  //     var uri = Uri.parse("${ApiData.baseUrl}${ApiData.user}/$id");

  //     var res = http.MultipartRequest('PATCh', uri)
  //       ..headers.addAll({
  //         'Authorization': 'Bearer $token',
  //       })
  //       ..fields['firstName'] = firstNamecontroller.text
  //       ..fields['mobileNumber'] = phoneController.text
  //       ..fields['facebookLink'] = faceBookController.text
  //       ..fields['instagramLink'] = instaController.text
  //       ..fields['twitterLink'] = twitterController.text
  //       ..fields['userName'] = userNameController.text;
  //     if (xImageFile != null) {
  //       res.files.add(
  //           await http.MultipartFile.fromPath('photoPath', xImageFile!.path));
  //     }

  //     var streamedResponse = await res.send();
  //     var response = await http.Response.fromStream(streamedResponse);
  //     // var result = jsonDecode(response.body);

  //     if (kDebugMode) {
  //       Get.log('Response from server: ${response.statusCode}');
  //     }

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> jsonData = json.decode(response.body);
  //       await userController.fetchUserDetails();

  //       User userDetail = User.fromJson(jsonData['user']);
  //       emailController.text = userDetail.email!;
  //       firstNamecontroller.text = userDetail.firstName!;
  //       userNameController.text = userDetail.userName!;
  //       phoneController.text = userDetail.mobileNumber!;
  //       xImageFile = await urlToXFile(userController.user!.photoPath!);

  //       update();

  //       CustomSnackBar.showSnackBar(
  //         title: "Profile Updated Successfully",
  //         isWarning: false,
  //       );
  //     } else {
  //       throw Exception(
  //           'Failed to upload image. Server responded with code ${response.statusCode}');
  //     }
  //     isLoading = false;
  //     update();
  //   } catch (e) {
  //     isLoading = false;
  //     update();

  //     if (kDebugMode) {
  //       Get.log("Error while uploading the image: $e");
  //     }
  //   }
  // }
}