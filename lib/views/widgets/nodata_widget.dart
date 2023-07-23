import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../consts/assets.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetsConstant.noData,
            scale: 3,
          ),
          const Text(
            "No Items Are Available",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
