import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:mapping_app/data/models/lat_long.dart';
import 'package:mapping_app/data/repositories/geocoding_repository.dart';

class SplashViewModel extends ChangeNotifier {
  SplashViewModel() {
    fetchCurrentLocation();
    listenCurrentLocation();
  }

  LocationModel? latLong;

  Location location = Location();

  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  LocationData? _locationData;

  Future<void> fetchCurrentLocation() async {
    //1-qadam location enable yoki disable ekanini tekshiradi!
    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    //2-qadam lokatsiyaga permission oladi!
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    //3-qadam lakatsiya oladi!
    _locationData = await location.getLocation();
    latLong = LocationModel(
      lattitude: _locationData!.longitude!,
      longitude: _locationData!.latitude!,
      dateTime: '',
    );
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));
  }

  listenCurrentLocation() {
    location.onLocationChanged.listen((event) {
      LocationModel locationModel = LocationModel(
        longitude: event.longitude?.toDouble() ?? 0,
        lattitude: event.latitude?.toDouble() ?? 0,
        dateTime: DateTime.now().toString(),
      );
      GeoCodingRepository().addLocation(locationModel);
      print(
        "LOCATION CHANGED : ${event.longitude}, ${event.latitude}",
      );
    });
  }
}
