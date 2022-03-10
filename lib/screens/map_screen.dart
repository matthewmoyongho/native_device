import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:native_devices/models/place.dart';

class MapScreen extends StatefulWidget {
  PlaceLocation placeLocation;
  bool isSelecting;
  MapScreen(
      {this.placeLocation = const PlaceLocation(
        lat: 37.7772,
        lon: -122.4303,
      ),
      this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? selectedLocation;
  void _pickLocation(LatLng position) {
    setState(() {
      selectedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location on Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: selectedLocation == null
                    ? null
                    : () => Navigator.of(context).pop(selectedLocation),
                icon: Icon(Icons.check_box))
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.placeLocation.lat,
              widget.placeLocation.lon,
            ),
            zoom: 16),
        onTap: widget.isSelecting ? _pickLocation : null,
        markers: selectedLocation == null && widget.isSelecting
            ? {}
            : {
                Marker(
                    markerId: const MarkerId('m1'),
                    position: selectedLocation ??
                        LatLng(widget.placeLocation.lat,
                            widget.placeLocation.lon)),
              },
      ),
    );
  }
}
