import 'package:flighttest/screens/results.dart';
import 'package:flutter/material.dart';
import 'package:flighttest/controllers/apiController.dart';
import 'package:flighttest/data/citynames.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ApiController apiController = Get.put(ApiController());

    String? fromCity;
    String? toCity;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Center(
          child: Container(
            width: double.infinity,
            color: Color.fromRGBO(35, 35, 35, 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      "From",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(
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
                        onSelected: (String? selection) async {
                          if (selection != null) {
                            fromCity = await apiController.fetchCode(selection);
                          }
                        },
                        fieldViewBuilder: (context, textEditingController,
                            focusNode, onEditingComplete) {
                          return TextField(
                            cursorColor: Colors.white,
                            controller: textEditingController,
                            focusNode: focusNode,
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: "From",
                              hintStyle: TextStyle(
                                color: Colors.white30,
                                fontWeight: FontWeight.bold,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusColor: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "To",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(
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
                        onSelected: (String? selection) async {
                          if (selection != null) {
                            toCity = await apiController.fetchCode(selection);
                          }
                        },
                        fieldViewBuilder: (context, textEditingController,
                            focusNode, onEditingComplete) {
                          return TextField(
                            cursorColor: Colors.white,
                            controller: textEditingController,
                            focusNode: focusNode,
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: "To",
                              hintStyle: TextStyle(
                                color: Colors.white30,
                                fontWeight: FontWeight.bold,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusColor: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (fromCity != null && toCity != null) {
                          Get.to(() => ResultsScreen(
                                fromCity: fromCity,
                                toCity: toCity,
                              ));
                        } else {
                          // Handle case where fromCity or toCity is null
                          print('Please select both From and To cities.');
                        }
                      },
                      child: const Text(
                        'Fetch Flight Data',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
