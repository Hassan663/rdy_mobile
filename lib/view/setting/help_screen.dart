
// screens/help_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/widgets/common_textfield.dart';
import 'package:intl_phone_field/intl_phone_field.dart'; // Assuming you're using this package for phone picker

class HelpScreen extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController queryController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header
            Container(
              padding:
                  const EdgeInsets.only(top: 60, bottom: 20, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () => Get.back(),
                    iconSize: 24,
                    splashRadius: 24,
                  ),
                  const Text(
                    "Help",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 40), // Spacer for symmetry
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        const Text(
                          "We're here to help! Please fill in your details below and our support team will get back to you as soon as possible.",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.blackButtoncolor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 30),
                    
                        // First Name and Last Name Fields in Row
                        Row(
                          children: [
                            Expanded(
                              child: CommonTextField(
                                controller: firstNameController,
                                hintText: "First Name",
                                isRequired: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;

                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CommonTextField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;

                                },
                                controller: lastNameController,
                                hintText: "Last Name",
                                isRequired: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                    
                        // Email Field
                        CommonTextField(
                          controller: emailController,
                          hintText: "Email",
                          // isRequired: true,
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            final emailRegex = RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        IntlPhoneField(
                          validator: (value) {
                            if (phoneController.text == null||phoneController.text.isEmpty) {
                              return 'Please enter your number';
                            }
                            return null;

                          },
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(),
                            ),
                          ),
                          initialCountryCode: 'US',
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                        ),
                        const SizedBox(height: 15),
                    
                        // Query Field
                        CommonTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your details';
                            }
                            return null;

                          },
                          controller: queryController,
                          hintText: "What can we help you with?",
                          isRequired: true,
                          prefixIcon: Icons.question_answer,
                          maxlines: 4,
                        ),
                        const SizedBox(height: 15),
                    
                        // Phone Number Field with Country Picker
                    
                        const SizedBox(height: 30),
                    
                        // Submit Button
                        Center(
                            child: CommonButton(text: "Submit", onPressed: () {})),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
