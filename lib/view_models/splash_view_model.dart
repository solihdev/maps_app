import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:mapping_app/data/models/lat_long.dart';

class SplashViewModel extends ChangeNotifier {
  SplashViewModel() {
    fetchCurrentLocation();
    listenCurrentLocation();
  }

  LatLong? latLong;

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
    latLong = LatLong(
      lattitude: _locationData!.longitude!,
      longitude: _locationData!.latitude!,
    );
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));
  }

  listenCurrentLocation() {
    location.onLocationChanged.listen((event) {
      print(
        "LOCATION CHANGED : ${event.latitude}, ${event.longitude}",
      );
    });
  }
}
