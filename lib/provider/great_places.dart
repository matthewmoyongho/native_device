import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:native_devices/helpers/db_helper.dart';
import 'package:native_devices/helpers/location_helper.dart';
import 'package:native_devices/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  Place findById(id) {
    return _places.firstWhere((element) => element.id == id);
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation location) async {
    final address =
        await LocationHelper.getPlaceAddress(location.lat, location.lon);
    final updatedLocation =
        PlaceLocation(lat: location.lat, lon: location.lon, address: address);
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        image: image,
        location: updatedLocation);
    _places.add(newPlace);
    notifyListeners();
    DBHelper.insert('User_Places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location!.lat,
      'loc_lon': newPlace.location!.lon,
      'address': newPlace.location!.address!
    });
  }

  Future<void> fetchPlaces() async {
    final placesList = await DBHelper.getPlaces('User_Places');
    _places = placesList
        .map(
          (e) => Place(
              id: e['id'],
              title: e['title'],
              image: File(e['image']),
              location: PlaceLocation(
                  lon: e['loc_lon'], lat: e['loc_lat'], address: e['address'])),
        )
        .toList();
    notifyListeners();
  }
}
