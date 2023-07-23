import 'package:bidbox/consts/styles.dart';
import 'package:bidbox/controllers/auction_controller.dart';
import 'package:bidbox/models/auction_item_model.dart';
import 'package:bidbox/views/widgets/item_card_shimmer.dart';
import 'package:bidbox/views/widgets/nodata_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/item_card.dart';

class AuctionScreen extends StatelessWidget {
  AuctionScreen({super.key});
  final AuctionController _auctionController = Get.put(AuctionController());
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
                hintStyle: const TextStyle(color: Colors.white),
                prefixIconColor: Colors.white,
                prefixIcon: const Icon(Icons.search)),
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: _auctionController.readItems(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Obx(() {
                  List<AuctionItem> items = _auctionController.searchWord.isEmpty
                      ? (snapshot.data
                              ?.where((element) =>
                                  element.userId !=
                                      FirebaseAuth.instance.currentUser!.uid &&
                                  element.endDate!
                                          .difference(DateTime.now())
                                          .inMinutes >
                                      0)
                              .toList() ??
                          [])
                      : (snapshot.data
                              ?.where((element) =>
                                  element.userId !=
                                      FirebaseAuth.instance.currentUser!.uid &&
                                  element.endDate!
                                          .difference(DateTime.now())
                                          .inMinutes >
                                      0 &&
                                  (element.name ?? "").toLowerCase().contains(
                                      _auctionController.searchWord.toLowerCase()))
                              .toList() ??
                          []);
                  if (items.isEmpty) {
                    return const NoDataWidget();
                  } else {
                    items.sort((a, b) => a.endDate!
                        .difference(DateTime.now())
                        .compareTo(b.endDate!.difference(DateTime.now())));
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
