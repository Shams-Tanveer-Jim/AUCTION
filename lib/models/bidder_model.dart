class BidderField {
  static const String id = "id";
  static const String name = "name";
  static const String bidPrice = "bidPrice";
}

class Bidder {
  String id;
  String name;
  String bidPrice;

  Bidder({required this.id, required this.name, required this.bidPrice});

  Map<String, dynamic> toJson() => {
        BidderField.id: id,
        BidderField.name: name,
        BidderField.bidPrice: bidPrice
      };

  static Bidder fromJson(Map<String, Object?> json) => Bidder(
      id: json[BidderField.id] as String,
      name: json[BidderField.name] as String,
      bidPrice: json[BidderField.bidPrice] as String);
}
