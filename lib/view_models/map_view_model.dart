import 'package:flutter/material.dart';
import 'package:mapping_app/data/models/lat_long.dart';
import '../data/repositories/geocoding_repository.dart';

class MapViewModel extends ChangeNotifier {
  MapViewModel({required this.geoCodingRepository});

  final GeoCodingRepository geoCodingRepository;

  String addressText = '';

  fetchAddress({required LocationModel latLong, required String kind}) async {
    addressText =
        await geoCodingRepository.getAddress(latLong,kind);
    notifyListeners();
  }
}
