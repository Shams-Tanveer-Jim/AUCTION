import 'package:bidbox/consts/assets.dart';
import 'package:bidbox/controllers/item_controller.dart';
import 'package:bidbox/models/auction_item_model.dart';
import 'package:bidbox/models/bidder_model.dart';
import 'package:bidbox/views/widgets/custom_button.dart';
import 'package:bidbox/views/widgets/dialogbox.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../consts/colors.dart';

class ItemDetailsScreen extends StatelessWidget {
  final String itemId;
  ItemDetailsScreen({required this.itemId, super.key});

  final ItemController _itemController = Get.put(ItemController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            ColorConstants.backgroundColor2,
            ColorConstants.backgroundColor1,
          ],
        ),
      ),
      child: StreamBuilder<AuctionItem>(
        stream: _itemController.readItem(itemId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            AuctionItem item = snapshot.data!;
            Duration daysLeft =
                item.endDate?.difference(DateTime.now()) ?? const Duration();
            item.bidders!.sort((a, b) => b.bidPrice.compareTo(a.bidPrice));

            return Scaffold(
              backgroundColor: ColorConstants.transparent,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: ColorConstants.transparent,
                  statusBarBrightness: Brightness.dark,
                  statusBarIconBrightness: Brightness.light,
                ),
                centerTitle: true,
                title: Text(item.name ?? ""),
                leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.keyboard_arrow_left)),
              ),
              body: Column(children: [
                CachedNetworkImage(
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain, image: imageProvider)),
                      );
                    },
                    imageUrl:
                        item.imagePath ?? AssetsConstant.defaultProductImage),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(15.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(7)),
                              child: ExpansionTile(
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide.none),
                                  title: const Text(
                                    "Auction Description",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  iconColor: Colors.amber,
                                  collapsedIconColor: Colors.amber,
                                  initiallyExpanded: true,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 10, 5, 10),
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(6),
                                              bottomRight: Radius.circular(6))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: "Min. Bid Price :",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                                const WidgetSpan(
                                                  child: SizedBox(
                                                    width: 2,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "৳ ${item.minimumBidPrice}",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: "Available :",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                                const WidgetSpan(
                                                  child: SizedBox(
                                                    width: 2,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${item.quantity} item ${int.parse(item.quantity ?? "") > 1 ? 's' : ''}",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                daysLeft.inMinutes < 0
                                                    ? const TextSpan(
                                                        text: "Bidding",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                        ),
                                                      )
                                                    : const TextSpan(
                                                        text: "Bidding Ends In",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                const WidgetSpan(
                                                    child: SizedBox(
                                                  width: 5,
                                                )),
                                                TextSpan(
                                                  text: daysLeft.inMinutes < 0
                                                      ? "Ended"
                                                      : "${daysLeft.inDays} days ${daysLeft.inHours % 24} hours ${daysLeft.inMinutes % 60} minutes",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ])),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(7)),
                            child: ExpansionTile(
                              shape: const RoundedRectangleBorder(
                                  side: BorderSide.none),
                              title: const Text(
                                "Product Description",
                                style: TextStyle(color: Colors.white),
                              ),
                              iconColor: Colors.amber,
                              collapsedIconColor: Colors.amber,
                              initiallyExpanded: true,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(6),
                                            bottomRight: Radius.circular(6))),
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 5, 16, 10),
                                    child: Text(item.description ?? ""),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(7)),
                            child: ExpansionTile(
                              shape: const RoundedRectangleBorder(
                                  side: BorderSide.none),
                              title: const Text(
                                "Bids List",
                                style: TextStyle(color: Colors.white),
                              ),
                              iconColor: Colors.amber,
                              collapsedIconColor: Colors.amber,
                              initiallyExpanded: true,
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(6),
                                          bottomRight: Radius.circular(6))),
                                  child: (item.bidders ?? []).isEmpty
                                      ? Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 5, 16, 10),
                                          child:
                                              const Text("No bid is placed."),
                                        )
                                      : daysLeft.inMinutes < 0
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      16, 5, 16, 10),
                                              child: Text(
                                                  "${item.bidders?.first.name ?? ''} wins the aution by bidding ${item.bidders?.first.bidPrice ?? ''} Tk"),
                                            )
                                          : Column(children: [
                                              const TableHeader(),
                                              ...item.bidders
                                                      ?.map((e) =>
                                                          TableContents(e))
                                                      .toList() ??
                                                  [],
                                            ]),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                item.userId == FirebaseAuth.instance.currentUser!.uid ||
                        item.bidders!
                            .where((element) =>
                                element.id ==
                                FirebaseAuth.instance.currentUser!.uid)
                            .isNotEmpty
                    ? Container()
                    : Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: customButton("Place Bid", () {
                          showbidAmountDialog(context, false);
                        }))
              ]),
            );
          } else {
            return const CircularProgressIndicator(
              color: ColorConstants.backgroundColor2,
            );
          }
        },
      ),
    );
  }
}

class TableHeader extends StatelessWidget {
  const TableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Expanded(flex: 10, child: Text("Name")),
          const Expanded(flex: 5, child: Text("Bid Price(Tk)")),
          Expanded(flex: 3, child: Container())
        ],
      ),
    );
  }
}

class TableContents extends StatelessWidget {
  Bidder bidder;
  TableContents(this.bidder, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      color: Colors.black.withOpacity(0.1),
      child: Row(
        children: [
          Expanded(flex: 10, child: Text(bidder.name)),
          Expanded(flex: 5, child: Text(bidder.bidPrice)),
          Expanded(
            flex: 3,
            child: bidder.id == FirebaseAuth.instance.currentUser!.uid
                ? IconButton(
                    onPressed: () {
                      showbidAmountDialog(context, true);
                    },
                    icon: const Icon(Icons.edit))
                : Container(),
          )
        ],
      ),
    );
  }
}
