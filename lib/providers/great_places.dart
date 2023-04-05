import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import '../models/place.dart';
import '../utils/db_util.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  Future<void> loadPlaces() async {
    final dataList = await DBUtil.getDatabase('places');

    _items = dataList.map(
      (item) => Place(
        id: item['id'],
        title: item['title'],
        location: null,
        image: File(item['image']),
      ),
    ).toList();

    notifyListeners();
  }

  List<Place> get item => [..._items];

  int get itemsCount => _items.length;

  Place itemByIndex(int index) => _items[index];

  void addPlace(String title, File image) {
    var newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      location: null,
      image: image,
    );

    _items.add(newPlace);

    DBUtil.insert(
      'places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
      },
    );

    notifyListeners();
  }
}
