import 'package:bidbox/consts/colors.dart';
import 'package:bidbox/consts/styles.dart';
import 'package:bidbox/controllers/item_controller.dart';
import 'package:bidbox/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../consts/assets.dart';
import '../../controllers/form_controller.dart';
import '../../services/image_picker.dart';

void showImageSourceDialog(BuildContext context) {
  final FormController formController = Get.find();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Choose an Image Source'),
        content: Container(
          height: 100,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            children: [
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  var pickedImage =
                      await ImagePickerService.pickImage(ImageSource.gallery);
                  formController.setImage(pickedImage);
                },
                child: Column(
                  children: [
                    Image.asset(
                      AssetsConstant.gallery,
                      scale: 8,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("GALLERY")
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  var pickedImage =
                      await ImagePickerService.pickImage(ImageSource.camera);
                  formController.setImage(pickedImage);
                },
                child: Column(
                  children: [
                    Image.asset(
                      AssetsConstant.camera,
                      scale: 8,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("CAMERA")
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

void showbidAmountDialog(BuildContext context, bool isUpdate) {
  final ItemController itemController = Get.find();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Obx(() => AlertDialog(
            backgroundColor: ColorConstants.backgroundColor2,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isUpdate
                      ? "Please Enter New Bid Amount!"
                      : 'Please Enter Your Bid Amount!',
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Min Bid Price ${itemController.item.value.minimumBidPrice}Tk",
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                )
              ],
            ),
            content: Container(
              height: 120,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  TextField(
                    controller: itemController.bidAmountController,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.black),
                    decoration: StyleConstants.textInputDecoration("Bid Amount")
                        .copyWith(
                            errorText: itemController.bidAmountError.isEmpty
                                ? null
                                : itemController.bidAmountError.value),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                    width: 70,
                    child: customButton(isUpdate ? "Update" : "Bid", () {
                      if (isUpdate) {
                        itemController.updateBid(context);
                      } else {
                        itemController.placeBid(context);
                      }
                    }),
                  )
                ],
              ),
            ),
          ));
    },
  );
}

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    },
  );
}
