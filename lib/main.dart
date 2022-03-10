import 'package:flutter/material.dart';
import 'package:native_devices/screens/places_details_screen.dart';
import 'package:provider/provider.dart';

import './provider/great_places.dart';
import './screens/add_place_screen.dart';
import './screens/places_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GreatPlaces>(
      create: (_) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primaryColor: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (context) => AddPlaceScreen(),
          PlacesDetailsScreen.routeName: (context) => PlacesDetailsScreen(),
        },
      ),
    );
  }
}
