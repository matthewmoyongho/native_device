import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:native_devices/helpers/location_helper.dart';
import 'package:native_devices/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final void Function(double lat, double lon) selectPlace;
  LocationInput(this.selectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewUrl;
  final Location _location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  void setPreviewImageUrl(double lat, double lon) {
    final locationPreviewUrl = LocationHelper.getLocationPreviewImage(lat, lon);

    setState(() {
      _previewUrl = locationPreviewUrl;
    });
  }

  Future<void> getUserLocation() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      await _location.requestPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        return;
      }
    }
    _locationData = await _location.getLocation();
    setPreviewImageUrl(_locationData.longitude!, _locationData.latitude!);
    widget.selectPlace(_locationData.latitude!, _locationData.longitude!);
  }

  Future<void> selectOnMap() async {
    final LatLng? selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    } else {
      final locationPreviewUrl = LocationHelper.getLocationPreviewImage(
          selectedLocation.latitude, selectedLocation.longitude);
      // final locationAddress = await LocationHelper.getPlaceAddress(
      //     selectedLocation.latitude, selectedLocation.longitude);
      setPreviewImageUrl(selectedLocation.latitude, selectedLocation.longitude);
      widget.selectPlace(selectedLocation.latitude, selectedLocation.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          child: _previewUrl == null
              ? const Text('No image selected')
              : Image.network(
                  _previewUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              onPressed: getUserLocation,
              label: const Text('Current Location'),
              style:
                  TextButton.styleFrom(primary: Theme.of(context).primaryColor),
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              onPressed: selectOnMap,
              label: const Text('Select on map'),
              style:
                  TextButton.styleFrom(primary: Theme.of(context).primaryColor),
            ),
          ],
        )
      ],
    );
  }
}
