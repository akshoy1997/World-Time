import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location name for the UI
  String time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for API end_pint
  bool isDaytime; // true or false if daytime or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
//    // simulate network request for a username
//    String username = await Future.delayed(Duration(seconds: 2), () {
//      return 'Akshay';
//    });
//
//    // simulate network request to get bio of the username
//    String favourite = await Future.delayed(Duration(seconds: 1), () {
//      return 'cold coffee';
//    });
//
//    print('$username loves $favourite');

    //make the API request
    try {
      Response response = await get(
          "http://worldtimeapi.org/api/timezone/$url");
      Map data = jsonDecode(response.body);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set time property
      isDaytime = now.hour > 6 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Caught Error: $e');
      time = "Wrong Endpoint: No time fetched";
    }
  }

}