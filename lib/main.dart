import 'package:flighttest/controllers/apiController.dart';
import 'package:flighttest/screens/search.dart';
import 'package:flighttest/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flight Search Demo',
      theme: ThemeData(),
      home: const SearchScreen(),
    );
  }
}

class FlightSearchScreen extends StatelessWidget {
  final ApiController apiController = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Search Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Call the fetchData function from the controller when the button is pressed
          },
          child: Text('Fetch Flight Data'),
        ),
      ),
    );
  }
}

class FlightListView extends StatelessWidget {
  final List flights;

  FlightListView({required this.flights});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: flights.length,
      itemBuilder: (context, index) {
        final flight = flights[index];
        return ListTile(
          title: Text('From: ${flight['cityFrom']}'),
          subtitle: Text(
              'To: ${flight['cityTo']} | Price: ${flight['price']} | Date: ${flight['local_departure']} | ${DateTime.parse(flight['local_departure'])}'),
        );
      },
    );
  }
}
