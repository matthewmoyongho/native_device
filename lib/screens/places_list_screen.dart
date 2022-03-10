import 'package:flutter/material.dart';
import 'package:native_devices/provider/great_places.dart';
import 'package:native_devices/screens/add_place_screen.dart';
import 'package:native_devices/screens/places_details_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: Icon(
                Icons.add,
              )),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? CircularProgressIndicator()
            : snapshot.hasError
                ? const Center(
                    child: Text(
                        'Unable to ge places at the moment. please try again later'),
                  )
                : Center(
                    child: Consumer<GreatPlaces>(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'No place added yet. Click on the plus icon above to add places',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      builder: (context, places, ch) => places.places.isEmpty
                          ? ch!
                          : ListView.builder(
                              itemCount: places.places.length,
                              itemBuilder: (context, i) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(places.places[i].image),
                                  ),
                                  title: Text(places.places[i].title),
                                  subtitle:
                                      Text(places.places[i].location!.address!),
                                  onTap: () => Navigator.of(context).pushNamed(
                                      PlacesDetailsScreen.routeName,
                                      arguments: places.places[i].id)),
                            ),
                    ),
                  ),
      ),
    );
  }
}
