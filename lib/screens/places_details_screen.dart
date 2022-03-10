import 'package:flutter/material.dart';
import 'package:native_devices/provider/great_places.dart';
import 'package:native_devices/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PlacesDetailsScreen extends StatelessWidget {
  static const String routeName = 'PlacesDetailsScreen';

  @override
  Widget build(BuildContext context) {
    final loadedId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedPlace = Provider.of<GreatPlaces>(context).findById(loadedId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedPlace.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              loadedPlace.image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            loadedPlace.location!.address!,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => MapScreen(
                      placeLocation: loadedPlace.location!,
                    ))),
            child: Text('View on map'),
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
