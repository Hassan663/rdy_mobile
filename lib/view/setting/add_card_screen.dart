import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/controller/setting/add_card_controller.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header with Back Button and Title
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
                    "Add Card",
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
                padding: const EdgeInsets.all(16.0),
                child: GetBuilder<AddCardController>(
                  init: AddCardController(),
                  builder: (controller) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 45,
                            width: 171,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: AppColors.primaryColor
                            ),
                            child: Row(
                              children: [
                                Spacer(),
                                Icon(Icons.qr_code,color: Colors.white,),
                                SizedBox(width: 10,),
                                Text("Scan Card",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                                Spacer(),
                              ],
                            ),
                          ),
                          CreditCardWidget(
                            cardNumber: controller.cardNumber,
                            expiryDate: controller.expiryDate,
                            cardHolderName: controller.cardHolderName,
                            cvvCode: controller.cvvCode,
                            showBackView: controller.isCvvFocused,
                            onCreditCardWidgetChange: (CreditCardBrand _) {},
                          ),
                          CreditCardForm(
                            formKey: controller.formKey,
                            cardNumber: controller.cardNumber,
                            expiryDate: controller.expiryDate,
                            cardHolderName: controller.cardHolderName,
                            cvvCode: controller.cvvCode,
                            onCreditCardModelChange:
                                controller.onCreditCardModelChange,
        
                            // themeColor: AppColors.primaryColor,
                            // cardNumberDecoration: InputDecoration(
                            //   labelText: 'Card Number',
                            //   hintText: 'XXXX XXXX XXXX XXXX',
                            //   border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(10),
                            //   ),
                            // ),
                            // expiryDateDecoration: InputDecoration(
                            //   labelText: 'Expiry Date',
                            //   hintText: 'MM/YY',
                            //   border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(10),
                            //   ),
                            // ),
                            // cvvCodeDecoration: InputDecoration(
                            //   labelText: 'CVV',
                            //   hintText: 'XXX',
                            //   border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(10),
                            //   ),
                            // ),
                            // cardHolderDecoration: InputDecoration(
                            //   labelText: 'Card Holder Name',
                            //   border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(10),
                            //   ),
                            // ),
                          ),
                          Row(
                            children: [
                            Obx(() => Checkbox(
                              checkColor: Colors.white,
                              fillColor: WidgetStatePropertyAll(controller.savecardcheckbox.value?AppColors.primaryColor:Colors.white),
                              value: controller.savecardcheckbox.value, onChanged: (value) {
                              controller.savecardcheckbox.value=value!;
                            },),),
                            Text("Save Card",style: TextStyle(fontWeight: FontWeight.w400),)
                            ],
                          ),
                          CommonButton(
                            width: Get.width-60,
                              text: "Save",
                              textStyle: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),
                              onPressed: () {
                                if (controller.formKey.currentState?.validate() ==
                                    true) {
                                  Get.snackbar(
                                      "Success", "Card Added Successfully!");
                                } else {
                                  Get.snackbar("Error",
                                      "Please fill out all fields correctly.");
                                }
                              }).marginOnly(top: 40)
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
