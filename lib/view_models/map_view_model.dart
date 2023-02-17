import 'package:flutter/material.dart';
import '../data/repositories/geocoding_repository.dart';

class MapViewModel extends ChangeNotifier {
  MapViewModel({required this.geoCodingRepository});

  final GeoCodingRepository geoCodingRepository;
}
