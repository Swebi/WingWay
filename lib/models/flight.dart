import 'dart:ffi';

class Flight {
  final String departureCity;
  final String departureCityCode;
  final String arrivalCity;
  final String arrivalCityCode;

  final String departureDateTime;
  final String arrivalDateTime;

  final String airline;
  final String logo;
  final String price;

  final Float durationHours;
  final Float durationMinutes;

  Flight({
    required this.departureCity,
    required this.departureCityCode,
    required this.arrivalCity,
    required this.arrivalCityCode,
    required this.departureDateTime,
    required this.arrivalDateTime,
    required this.airline,
    required this.logo,
    required this.price,
    required this.durationHours,
    required this.durationMinutes,
  });
}
