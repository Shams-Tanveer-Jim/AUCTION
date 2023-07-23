import 'package:flutter/material.dart';

Widget customButton(String buttonName, Function buttonFunction) {
  return GestureDetector(
    onTap: () {
      buttonFunction();
    },
    child: Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient:
              const LinearGradient(colors: [Colors.amber, Colors.orange])),
      child: Center(
          child: Text(
        buttonName,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
      )),
    ),
  );
}
