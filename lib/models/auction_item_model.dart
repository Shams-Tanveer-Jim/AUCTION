import 'package:cloud_firestore/cloud_firestore.dart';

import 'bidder_model.dart';

class AuctionItemField {
  static const String id = "id";
  static const String name = "name";
  static const String quantity = "quantity";
  static const String userId = "userId";
  static const String description = "description";
  static const String imagePath = "imagePath";
  static const String minimumBidPrice = "minimumBidPrice";
  static const String bidders = "bidders";
  static const String endDate = "endDate";
}

class AuctionItem {
  String? id;
  String? name;
  String? quantity;
  String? userId;
  String? description;
  String? imagePath;
  String? minimumBidPrice;
  List<Bidder>? bidders;
  DateTime? endDate;

  AuctionItem(
      {this.id,
      this.name,
      this.quantity,
      this.userId,
      this.description,
      this.imagePath,
      this.minimumBidPrice,
      this.bidders,
      this.endDate});

  Map<String, dynamic> toJson() => {
        AuctionItemField.id: id,
        AuctionItemField.name: name,
        AuctionItemField.quantity: quantity,
        AuctionItemField.userId: userId,
        AuctionItemField.description: description,
        AuctionItemField.imagePath: imagePath,
        AuctionItemField.minimumBidPrice: minimumBidPrice,
        AuctionItemField.bidders: bidders,
        AuctionItemField.endDate: endDate
      };
  static AuctionItem fromJson(Map<String, Object?> json) {
    var bidders = json[AuctionItemField.bidders] as List<dynamic>;
    List<Bidder> bidderList =
        bidders.map((item) => Bidder.fromJson(item)).toList();
    return AuctionItem(
        id: json[AuctionItemField.id] as String,
        name: json[AuctionItemField.name] as String,
        quantity: json[AuctionItemField.quantity] as String,
        userId: json[AuctionItemField.userId] as String,
        description: json[AuctionItemField.description] as String,
        imagePath: json[AuctionItemField.imagePath] as String,
        minimumBidPrice: json[AuctionItemField.minimumBidPrice] as String,
        bidders: bidderList,
        endDate: (json[AuctionItemField.endDate] as Timestamp).toDate());
  }
}
