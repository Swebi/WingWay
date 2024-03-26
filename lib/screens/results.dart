import 'package:flighttest/components/TicketView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flighttest/controllers/apiController.dart';

class ResultsScreen extends StatelessWidget {
  ResultsScreen({
    Key? key,
    required this.fromCity,
    required this.toCity,
  }) : super(key: key);

  final fromCity;
  final toCity;

  @override
  Widget build(BuildContext context) {
    final ApiController apiController = Get.put(ApiController());

    return FutureBuilder(
      future: apiController.fetchData(fromCity, toCity),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        } else {
          List<dynamic>? flightlist = snapshot.data;
          if (flightlist != null && flightlist.isNotEmpty) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                title: const Text(
                  "Search Results",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                elevation: 1,
              ),
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              body: FutureBuilder(
                future: _fetchFlightDetails(apiController, flightlist),
                builder:
                    (context, AsyncSnapshot<List<TicketData>> flightSnapshot) {
                  if (flightSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    List<TicketData>? ticketList = flightSnapshot.data;
                    if (ticketList != null && ticketList.isNotEmpty) {
                      return ListView.builder(
                        itemCount: ticketList.length,
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        itemBuilder: (context, index) {
                          final ticketData = ticketList[index];
                          return TicketView(
                            departureCity: ticketData.departureCity,
                            departureDate: ticketData.departureDate,
                            departureTime: ticketData.departureTime,
                            arrivalCity: ticketData.arrivalCity,
                            arrivalDate: ticketData.arrivalDate,
                            arrivalTime: ticketData.arrivalTime,
                            airline: ticketData.airline,
                            price: ticketData.price,
                            durationHours: ticketData.durationHours,
                            durationMinutes: ticketData.durationMinutes,
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('No flights available'));
                    }
                  }
                },
              ),
            );
          } else {
            return const Center(child: Text('No flights available'));
          }
        }
      },
    );
  }

  Future<List<TicketData>> _fetchFlightDetails(
      ApiController apiController, List<dynamic> flightlist) async {
    List<TicketData> ticketList = [];
    for (int index = 0; index < flightlist.length; index++) {
      final departureCity = flightlist[index]['cityFrom'];
      final arrivalCity = flightlist[index]['cityTo'];
      final departureCode = await apiController.fetchCode(departureCity);
      final arrivalCode = await apiController.fetchCode(arrivalCity);

      final departureDateTime =
          DateTime.parse(flightlist[index]['local_departure']);
      final arrivalDateTime =
          DateTime.parse(flightlist[index]['local_arrival']);

      final departureDate = _formatDate(departureDateTime);
      final departureTime = _formatTime(departureDateTime);
      final arrivalDate = _formatDate(arrivalDateTime);
      final arrivalTime = _formatTime(arrivalDateTime);

      final airline = flightlist[index]['airlines'][0];
      final price = flightlist[index]['price'];
      final durationHours = flightlist[index]['duration']['total'] ~/ 3600;
      final durationMinutes =
          (flightlist[index]['duration']['total'] % 3600) ~/ 60;

      ticketList.add(TicketData(
        departureCity: departureCode.toString(),
        departureDate: departureDate,
        departureTime: departureTime,
        arrivalCity: arrivalCode.toString(),
        arrivalDate: arrivalDate,
        arrivalTime: arrivalTime,
        airline: airline.toString(),
        price: price.toString(),
        durationHours: durationHours.toString(),
        durationMinutes: durationMinutes.toString(),
      ));
    }
    return ticketList;
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}-'
        '${dateTime.month.toString().padLeft(2, '0')}-'
        '${dateTime.year.toString()}';
  }

  String _formatTime(DateTime dateTime) {
    String period = 'AM';
    int hour = dateTime.hour;
    if (hour > 12) {
      hour -= 12;
      period = 'PM';
    }
    return '${hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')} $period';
  }
}

class TicketData {
  final String departureCity;
  final String departureDate;
  final String departureTime;
  final String arrivalCity;
  final String arrivalDate;
  final String arrivalTime;
  final String airline;
  final String price;
  final String durationHours;
  final String durationMinutes;

  TicketData({
    required this.departureCity,
    required this.departureDate,
    required this.departureTime,
    required this.arrivalCity,
    required this.arrivalDate,
    required this.arrivalTime,
    required this.airline,
    required this.price,
    required this.durationHours,
    required this.durationMinutes,
  });
}
