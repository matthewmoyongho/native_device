import 'dart:io';

class PlaceLocation {
  final double lat;
  final double lon;
  final String? address;
  const PlaceLocation({this.address, required this.lat, required this.lon});
}

class Place {
  final String id;
  final String title;
  final PlaceLocation? location;
  final File image;
  Place(
      {required this.id,
      required this.title,
      required this.image,
      required this.location});
}
