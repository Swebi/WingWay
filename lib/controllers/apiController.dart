import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiController extends GetxController {
  var fromCity = ''.obs;
  var toCity = ''.obs;

  Future<String> fetchCode(String cityName) async {
    String cityUrl =
        "https://api.tequila.kiwi.com/locations/query?term=$cityName&locale=en-US&location_types=city&limit=10&active_only=true";
    final cityresponse = await http.get(
      Uri.parse(cityUrl),
      headers: {
        'accept': 'application/json',
        'apikey': 'ZHhz7d8zFUo9Am0xWyouUxS6wOyAwstG',
      },
    );
    if (cityresponse.statusCode == 200) {
      final jsonData = jsonDecode(cityresponse.body);
      final flights = jsonData['locations'] as List<dynamic>;
      String code = flights[0]["code"];
      code = code.replaceAll('"', '');

      return code.toString();
    } else {
      return ''; // Return empty string if code fetching fails
    }
  }

  Future<List<dynamic>> fetchData(String fromCity, String toCity) async {
    String apiUrl =
        'https://api.tequila.kiwi.com/v2/search?fly_from=$fromCity&fly_to=$toCity&date_from=01%2F04%2F2024&date_to=01%2F04%2F2024&ret_from_diff_city=false&ret_to_diff_city=false&one_for_city=0&one_per_date=0&adults=1&partner_market=us&curr=INR&locale=in&max_stopovers=0&vehicle_type=aircraft&sort=price&limit=50';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'accept': 'application/json',
        'apikey': 'ZHhz7d8zFUo9Am0xWyouUxS6wOyAwstG',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final flights = jsonData['data'] as List<dynamic>;
      List<dynamic> flightList = flights;

      return flightList;
    } else {
      print('Request failed with status: ${response.statusCode}');
      return []; // Return empty list if request fails
    }
  }
}
