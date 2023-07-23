import 'package:bidbox/views/widgets/item_card.dart';
import 'package:bidbox/views/widgets/item_card_shimmer.dart';
import 'package:bidbox/views/widgets/nodata_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/styles.dart';
import '../controllers/auction_controller.dart';

class MyBidsScreen extends StatelessWidget {
  MyBidsScreen({super.key});

  final AuctionController _auctionController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              _auctionController.onChange(value);
            },
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            controller: _auctionController.searchController,
            decoration: StyleConstants.textInputDecoration("Search").copyWith(
                fillColor: Colors.black.withOpacity(0.3),
                hintStyle: TextStyle(color: Colors.white),
                prefixIconColor: Colors.white,
                prefixIcon: Icon(Icons.search)),
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: _auctionController.readItems(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Obx(() {
                  User currentUser = FirebaseAuth.instance.currentUser!;
                  var items = _auctionController.searchWord.isEmpty
                      ? (snapshot.data?.where((element) => element.bidders!.any(
                              (element) => element.id == currentUser.uid)) ??
                          [])
                      : (snapshot.data?.where((element) =>
                              element.bidders!.any(
                                  (element) => element.id == currentUser.uid) &&
                              (element.name ?? "").toLowerCase().contains(
                                  _auctionController.searchWord
                                      .toLowerCase())) ??
                          []);
                  if (items.isEmpty) {
                    return const NoDataWidget();
                  } else {
                    return ListView(
                      shrinkWrap: true,
                      children: items.map((e) => ItemCard(e)).toList(),
                    );
                  }
                });
              } else {
                return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (_, index) => const ItemCardShimmer());
              }
            },
          ),
        ),
      ],
    );
  }
}
