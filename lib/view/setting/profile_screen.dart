import 'dart:io';

import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/controller/setting/profile_controller.dart';
import 'package:ryd4ride/widgets/common_container.dart';
import 'package:ryd4ride/widgets/common_image_picker.dart';

class EditUserDetails extends StatelessWidget {
  const EditUserDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
        init: EditProfileController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
                backgroundColor: AppColors.primaryColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                centerTitle: true,
                title: const MyText(
                  text: "Edit Profile",
                  fontFamily: "Roboto",
                  color: Colors.white,
                )),
            body: SafeArea(child: bodyData(context, _)),
          );
        });
  }

  Widget bodyData(BuildContext context, EditProfileController _) {
    return _.isLoading
        ? const Center(child: IsLoading())
        : SingleChildScrollView(
            child: Column(
              children: [
                // ------------------------------ Image Box ------------------------------------------

                CommonContainerWithOutContent(
                  content: Stack(
                    children: [
                      CircleAvatar(
                        foregroundColor: AppColors.primaryColor,
                        radius: 75,
                        backgroundColor: AppColors.primaryColor,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 70,
                          backgroundImage: _.xImageFile != null
                              ? FileImage(File(_.xImageFile!.path))
                                  as ImageProvider
                              : const AssetImage(AppAssets.appLogo),
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: GestureDetector(
                          onTap: () {
                            ImagePickerUtils.showImagePickerModalSheet(context,
                                onTapCamera: () {
                              _.getFromCamera();
                              Get.back();
                            }, onTapGallery: () {
                              _.getFromGallery();
                              Get.back();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                  color: AppColors.primaryColor,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    50,
                                  ),
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(2, 4),
                                    color: Colors.black.withOpacity(
                                      0.3,
                                    ),
                                    blurRadius: 3,
                                  ),
                                ]),
                            child: const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Icon(Icons.edit, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).marginOnly(top: 20, bottom: 30, left: 30, right: 30),
                ).marginSymmetric(horizontal: 20, vertical: 20),
                CommonContainer(
                    heading: "Email Address",
                    content: CommonTextField(
                      isRequired: false,
                      fillcolor: AppColors.whitecolor,
                      controller: _.emailController,
                      readOnly: true,
                      hintText: "Enter Email Address",
                    )),
                CommonContainer(
                    heading: "First Name",
                    content: CommonTextField(
                      isRequired: false,
                      fillcolor: AppColors.whitecolor,
                      controller: _.firstNamecontroller,
                      hintText: "Enter First Name",
                    )).marginSymmetric(vertical: 10),
                CommonContainer(
                    heading: "User Name",
                    content: CommonTextField(
                      isRequired: false,
                      fillcolor: AppColors.whitecolor,
                      controller: _.userNameController,
                      hintText: "Enter User Name",
                    )),
                CommonContainer(
                    heading: "Phone",
                    content: CommonTextField(
                      isRequired: false,
                      fillcolor: AppColors.whitecolor,
                      controller: _.phoneController,
                      hintText: "Enter Phone Number",
                    )).marginSymmetric(vertical: 10),
                // --------------------------------- Submit -------------------------------

                CommonButton(

                    text: "Submit",
                    onPressed: () async {
                      if (_.firstNamecontroller.text.isEmpty ||
                          _.userNameController.text.isEmpty ||
                          _.phoneController.text.isEmpty) {
                        // ConfirmationDialog.showConfirmationDialog(
                        //     title: 'Warning',
                        //     description:
                        //         'You need to Complete your profile to add any service. Still want to continue?',
                        //     onYesPressed: () async {
                        //       Get.back();
                        //       await _.editprofile();
                        //     });
                      } else {
                        // await _.editprofile();
                      }
                    }).marginSymmetric(horizontal: 40, vertical: 30)
              ],
            ),
          );
  }
}
