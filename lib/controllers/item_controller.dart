import 'package:bidbox/models/bidder_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/auction_item_model.dart';

class ItemController extends GetxController {
  final TextEditingController bidAmountController = TextEditingController();
  RxString bidAmountError = "".obs;
  String itemId = "";
  Rx<AuctionItem> item = AuctionItem().obs;
  Stream<AuctionItem> readItem(String id) {
    itemId = id;
    return FirebaseFirestore.instance
        .collection("auctionitems")
        .doc(id)
        .snapshots()
        .map((snapShot) {
      item.value = AuctionItem.fromJson(snapShot.data() ?? {});
      return item.value;
    });
  }

  placeBid(BuildContext context) async {
    if (bidAmountController.text == "") {
      bidAmountError.value = "Please Enter Bid Amount";
    } else {
      bidAmountError.value = "";
      User currentUser = FirebaseAuth.instance.currentUser!;
      var bidder = Bidder(
              id: currentUser.uid,
              name: currentUser.displayName ?? "",
              bidPrice: bidAmountController.text)
          .toJson();
      await FirebaseFirestore.instance
          .collection("auctionitems")
          .doc(itemId)
          .update({
        "bidders": FieldValue.arrayUnion([bidder])
      }).then((value) {
        FirebaseFirestore.instance
            .collection("userbids")
            .add({"id": itemId, "userId": currentUser.uid}).then((value) {
          Navigator.pop(context);
        });
      });
    }
  }

  updateBid(BuildContext context) async {
    if (bidAmountController.text == "") {
      bidAmountError.value = "Please Enter Bid Amount";
    } else {
      bidAmountError.value = "";
      User currentUser = FirebaseAuth.instance.currentUser!;
      FirebaseFirestore.instance
          .collection("auctionitems")
          .doc(itemId)
          .get()
          .then((value) => AuctionItem.fromJson(value.data() ?? {}).bidders)
          .then((value) async {
        var prevBidders = value;
        for (Bidder bidder in prevBidders!) {
          if (bidder.id == currentUser.uid) {
            prevBidders[prevBidders.indexOf(bidder)].bidPrice =
                bidAmountController.text;
            break;
          }
        }
        List<Map<String, dynamic>> updatedBidders =
            prevBidders.map((e) => e.toJson()).toList();
        await FirebaseFirestore.instance
            .collection("auctionitems")
            .doc(itemId)
            .update({"bidders": updatedBidders}).then((value) {
          Navigator.pop(context);
        });
      });
    }
  }
}
