import 'package:bidbox/models/auction_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuctionController extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxString searchWord = "".obs;
  onChange(String value) {
    searchWord.value = value;
  }

  Stream<List<AuctionItem>> readItems() => FirebaseFirestore.instance
      .collection("auctionitems")
      .snapshots()
      .map((snapShot) => snapShot.docs
          .map((doc) => AuctionItem.fromJson(doc.data()))
          .toList());
}
