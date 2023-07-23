import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmeRoundedrRectangle extends StatelessWidget {
  final double height;
  final double width;
  const CustomShimmeRoundedrRectangle(
      {super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Center(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}

class CustomShimmerRectangle extends StatelessWidget {
  final double height;
  final double width;
  const CustomShimmerRectangle(
      {super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Center(
        child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
            )),
      ),
    );
  }
}

class CustomShimmerCircular extends StatelessWidget {
  final double height;
  final double width;
  const CustomShimmerCircular(
      {super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Center(
        child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(30))),
      ),
    );
  }
}
