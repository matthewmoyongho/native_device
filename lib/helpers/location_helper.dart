import 'dart:convert';

import 'package:http/http.dart' as http;

const String mapAPIKey = 'AIzaSyDQ-fQxtf5v0G6iz7rEU1Oz3rE24gUmKOU';

class LocationHelper {
  static String getLocationPreviewImage(double lon, double lat) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lon&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$lat,$lon&key=$mapAPIKey";
  }

  static Future<String> getPlaceAddress(double lat, double lon) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=$mapAPIKey';
    final urlr =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=Y$mapAPIKey';
    http.Response response = await http.get(Uri.parse(url));
    final responseData =
        jsonDecode(response.body)['results'][0]['formatted_address'];
    // print(responseData);
    return responseData;
  }
}
