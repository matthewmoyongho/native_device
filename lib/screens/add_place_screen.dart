import 'dart:io';

import 'package:flutter/material.dart';
import 'package:native_devices/models/place.dart';
import 'package:provider/provider.dart';

import '../provider/great_places.dart';
import '../widget/image_input.dart';
import '../widget/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/addScreen';
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  File? pickedImage;
  PlaceLocation? _pickedLocation;
  saveImage(File image) {
    pickedImage = image;
  }

  void savePlace() {
    if (_titleController.text.isEmpty &&
        pickedImage == null &&
        _pickedLocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, pickedImage!, _pickedLocation!);
    Navigator.of(context).pop();
  }

  void _selectPlace(double lat, double lon) {
    _pickedLocation = PlaceLocation(lat: lat, lon: lon);
  }

  TextEditingController _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(saveImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: savePlace,
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).accentColor,
                onPrimary: Colors.black),
          )
        ],
      ),
    );
  }
}
