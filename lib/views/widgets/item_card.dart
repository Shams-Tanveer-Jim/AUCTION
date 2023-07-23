import 'package:bidbox/consts/assets.dart';
import 'package:bidbox/views/item_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/auction_item_model.dart';

class ItemCard extends StatelessWidget {
  final AuctionItem item;
  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    Duration daysLeft =
        item.endDate?.difference(DateTime.now()) ?? const Duration();

    return GestureDetector(
      onTap: () {
        Get.to(() => ItemDetailsScreen(itemId: item.id!));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: CachedNetworkImage(
            imageBuilder: (context, imageProvider) => Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  image: DecorationImage(image: imageProvider),
                  borderRadius: BorderRadius.circular(30)),
            ),
            imageUrl: item.imagePath ?? AssetsConstant.defaultProductImage,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              (item.name ?? "").toUpperCase(),
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (item.description ?? ""),
                style: const TextStyle(fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 5,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    daysLeft.inMinutes < 0
                        ? const TextSpan(
                            text: "",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontStyle: FontStyle.italic),
                          )
                        : const TextSpan(
                            text: "Ends in",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontStyle: FontStyle.italic),
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
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                          color: Colors.amber),
                    )
                  ],
                ),
              )
            ],
          ),
          trailing: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(7)),
            child: Text("৳ ${item.minimumBidPrice}"),
          ),
        ),
      ),
    );
  }
}
