import 'package:bidbox/models/auction_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

class DashBoradController extends GetxController {
  Stream<List<int>> readData() => FirebaseFirestore.instance
          .collection("auctionitems")
          .snapshots()
          .map((snapShot) {
        int totalAuction = 0;
        int totalAuctionRunning = 0;
        int totalAuctionEnded = 0;
        int totalAuctionWithBids = 0;
        int totalAuctionWithoutBids = 0;
        int totalAuctionPrice = 0;

        for (var i = 0; i < snapShot.docs.length; i++) {
          AuctionItem item = AuctionItem.fromJson(snapShot.docs[i].data());
          totalAuction += 1;

          (item.bidders ?? []).sort(
              (a, b) => int.parse(b.bidPrice).compareTo(int.parse(a.bidPrice)));

          if ((item.endDate ?? DateTime.now())
                  .difference(DateTime.now())
                  .inMinutes >
              0) {
            totalAuctionRunning += 1;
          } else {
            totalAuctionPrice += (item.bidders ?? []).isEmpty
                ? 0
                : int.parse(item.quantity ?? "0") *
                    int.parse(item.bidders?.first.bidPrice ?? "0");
            totalAuctionEnded += 1;
          }
          if ((item.bidders ?? []).isNotEmpty) {
            totalAuctionWithBids += 1;
          } else {
            totalAuctionWithoutBids += 1;
          }
        }

        return [
          totalAuction,
          totalAuctionPrice,
          totalAuctionRunning,
          totalAuctionEnded,
          totalAuctionWithBids,
          totalAuctionWithoutBids
        ];
      });
}
