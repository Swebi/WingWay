// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flighttest/controllers/apiController.dart';
import 'package:flighttest/data/citynames.dart';
import 'package:get/get.dart';

class AutoSearch extends StatelessWidget {
  const AutoSearch(
    this.hintText, {
    super.key,
  });

  final String hintText;

  @override
  Widget build(
    BuildContext context,
  ) {
    final ApiController apiController = Get.put(ApiController());

    return SizedBox(
      width: 200,
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<String>.empty();
          }
          return citynames.where((String option) {
            return option
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (selection) async {
          if (selection != null) {
            if (hintText == "From") {
              apiController.fromCity = RxString(selection);
            } else {
              apiController.toCity = RxString(selection);
            }
          }
        },
        fieldViewBuilder:
            (context, textEditingController, focusNode, onEditingComplete) {
          return TextField(
            textInputAction: TextInputAction.done,
            controller: textEditingController,
            focusNode: focusNode,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.white30,
                fontWeight: FontWeight.bold,
              ),
              focusColor: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
