import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/great_places.dart';
import 'screens/place_details_screen.dart';
import 'screens/place_form_screen.dart';
import 'screens/place_list_screen.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.indigo,
            secondary: Colors.amber,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const PlacesListScreen(),
        routes: {
          AppRoutes.placeForm: (_) => const PlaceFormScreen(),
          AppRoutes.placeDetails: (_) => const PlaceDetailsScreen(),
        },
      ),
    );
  }
}
