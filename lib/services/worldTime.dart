import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // Location name for the UI
  String time = ''; // The time in that location
  String flag; // URL to the asset of the flag
  String locUrl; // Location URL for API endpoint
  bool isDaytime = true; //tells whether its daytime or not

  WorldTime({required this.location, required this.flag, required this.locUrl});

  Future<void> getTime() async {
    try {
      // Make an HTTP request
      Uri url = Uri.parse('https://worldtimeapi.org/api/timezone/$locUrl');
      Response response = await get(url);
      Map data = jsonDecode(response.body);

      // Get properties from JSON
      String datetime = data['datetime'];
      String offset = data['utc_offset'];

      DateTime now = DateTime.parse(datetime);
      int offsetHours = int.parse(offset.substring(1, 3));
      int offsetMinutes = int.parse(offset.substring(4, 6));

      if (offset[0] == '+') {
        now = now.add(Duration(hours: offsetHours, minutes: offsetMinutes));
      } else {
        now = now.subtract(Duration(hours: offsetHours, minutes: offsetMinutes));
      }

      isDaytime = now.hour>6 && now.hour<18 ? true:false;
      // Set time property
      time = DateFormat.jm().format(now);
    } catch (e) {
      time = 'Could not get time data';
    }
  }
}
