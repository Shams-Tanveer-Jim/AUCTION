import 'package:bidbox/views/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';

class ItemCardShimmer extends StatelessWidget {
  const ItemCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const CustomShimmerCircular(
              height: 50,
              width: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            const Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomShimmerRectangle(height: 20, width: 150),
                ),
                CustomShimmerRectangle(height: 15, width: 150),
                SizedBox(
                  height: 5,
                ),
                CustomShimmerRectangle(height: 15, width: 150)
              ],
            ),
            const SizedBox(
              width: 30,
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(7)),
              child: const CustomShimmerRectangle(height: 20, width: 45),
            )
          ],
        ));
  }
}
