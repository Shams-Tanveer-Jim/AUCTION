import 'package:bidbox/views/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';

class DashBoardShimmer extends StatelessWidget {
  const DashBoardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: const CustomShimmeRoundedrRectangle(
            height: 120,
            width: double.infinity,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: const Row(
            children: [
              CustomShimmeRoundedrRectangle(
                height: 130,
                width: 165,
              ),
              SizedBox(
                width: 10,
              ),
              CustomShimmeRoundedrRectangle(
                height: 130,
                width: 165,
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: const CustomShimmeRoundedrRectangle(
            height: 180,
            width: double.infinity,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: const CustomShimmeRoundedrRectangle(
            height: 120,
            width: double.infinity,
          ),
        ),
      ],
    );
  }
}
