import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/colors.dart';
import '../../consts/styles.dart';
import '../../controllers/form_controller.dart';
import 'custom_button.dart';
import 'dialogbox.dart';

class ShowAddProductForm extends StatelessWidget {
  ShowAddProductForm({super.key});

  final FormController _formController = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    ColorConstants.backgroundColor2,
                    ColorConstants.backgroundColor1,
                  ]),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: _formController.isLoading.value
                ? SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 85, horizontal: 10),
                      child: Column(
                        children: [
                          const Text(
                            "PRODUCT INFORMATION",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextField(
                                controller: _formController.nameController,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration:
                                    StyleConstants.textInputDecoration("Name")
                                        .copyWith(
                                            errorText: _formController
                                                    .nameError.isEmpty
                                                ? null
                                                : _formController
                                                    .nameError.value),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller:
                                    _formController.descriptionController,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                maxLines: 5,
                                decoration: StyleConstants.textInputDecoration(
                                    "Description"),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showImageSourceDialog(context);
                                },
                                child: TextField(
                                  controller: _formController.imageController,
                                  enabled: false,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration:
                                      StyleConstants.textInputDecoration(
                                              "Photo")
                                          .copyWith(),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _formController.quantityController,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Colors.black),
                                decoration: StyleConstants.textInputDecoration(
                                    "Quantity"),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _formController.bidPriceController,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Colors.black),
                                decoration: StyleConstants.textInputDecoration(
                                        "Min. Bid Price")
                                    .copyWith(
                                        errorText: _formController
                                                .bidError.isEmpty
                                            ? null
                                            : _formController.bidError.value),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(
                                      const Duration(days: 60),
                                    ),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: const ColorScheme.light(
                                              primary: ColorConstants
                                                  .backgroundColor2,
                                              onPrimary: Colors.white),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.black,
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );

                                  _formController.setDate(pickedDate);
                                },
                                child: TextField(
                                  enabled: false,
                                  controller: _formController.endDateController,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration:
                                      StyleConstants.textInputDecoration(
                                          "End Date"),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: customButton("BACK", () {
                                      Navigator.pop(context);
                                    }),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: customButton("ADD", () {
                                      _formController.submitData(context);
                                    }),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ),
        ),
      );
    });
  }
}
