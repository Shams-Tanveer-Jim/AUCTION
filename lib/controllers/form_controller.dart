import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../consts/assets.dart';
import '../models/auction_item_model.dart';
import '../services/image_picker.dart';

class FormController extends GetxController {
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController bidPriceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  Map<String, dynamic>? pickedImage;
  DateTime endDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59);
  String imageUrl = AssetsConstant.defaultProductImage;

  RxBool isLoading = true.obs;

  RxString nameError = "".obs;
  RxString bidError = "".obs;

  setDate(DateTime? dateTime) {
    endDate = DateTime(
        dateTime?.year ?? DateTime.now().year,
        dateTime?.month ?? DateTime.now().month,
        dateTime?.day ?? DateTime.now().day,
        23,
        59);

    endDateController.text = dateTime == null
        ? "End Date"
        : DateFormat('yyyy-MM-dd').format(endDate);
  }

  setImage(Map<String, dynamic> pickedImageFile) {
    pickedImage = pickedImageFile;
    imageController.text = pickedImage?["name"] ?? "Photo";
  }

  bool validateForm() {
    bool flag = true;
    if (nameController.text == "") {
      nameError.value = "Please Enter Product Name";
      flag = false;
    } else {
      nameError.value = "";
    }

    if (bidPriceController.text == "") {
      bidError.value = "Please Enter Product Name";
      flag = false;
    } else {
      bidError.value = "";
    }
    return flag;
  }

  submitData(BuildContext context) async {
    if (validateForm()) {
      if (pickedImage != null) {
        imageUrl = await ImagePickerService.getDownLoadableUrl(
            pickedImage!["name"], pickedImage!["file"]);
      }

      final user = FirebaseAuth.instance.currentUser;

      AuctionItem auctionItem = AuctionItem(
          name: nameController.text.trim(),
          quantity:
              quantityController.text == "" ? "1" : quantityController.text,
          description: descriptionController.text.trim(),
          imagePath: imageUrl,
          minimumBidPrice: bidPriceController.text,
          bidders: [],
          endDate: endDate,
          userId: user?.uid ?? "");

      nameController.clear();
      descriptionController.clear();
      imageController.clear();
      bidPriceController.clear();
      endDateController.clear();

      await FirebaseFirestore.instance
          .collection("auctionitems")
          .add(auctionItem.toJson())
          .then((value) {
        auctionItem.id = value.id;
        value.set(auctionItem.toJson());
      }).then((value) {
        Navigator.pop(context);
      });
    }
  }
}
