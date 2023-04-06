import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../utils/app_routes.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Lugares'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.placeForm),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: const Center(
                  child: Text('Nenhum local cadastrado!'),
                ),
                builder: (context, greatPlaces, child) =>
                    greatPlaces.itemsCount == 0
                        ? child!
                        : ListView.builder(
                            itemCount: greatPlaces.itemsCount,
                            itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                    greatPlaces.itemByIndex(index).image),
                              ),
                              title: Text(greatPlaces.itemByIndex(index).title),
                              subtitle: Text(greatPlaces
                                  .itemByIndex(index)
                                  .location!
                                  .address!),
                              onTap: () => Navigator.of(context).pushNamed(
                                AppRoutes.placeDetails,
                                arguments: greatPlaces.itemByIndex(index),
                              ),
                            ),
                          ),
              ),
      ),
    );
  }
}
