import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/services/geo_locator_service.dart';

class GeoLocatorProvider extends ChangeNotifier {
  final GeoLocatorService _geoLocatorService = GeoLocatorService();
  Position? _currentPosition;

  double? _latitude;
  double? _longitude;

  Position? get currentPosition => _currentPosition;
  double? get latitude => _latitude;
  double? get longitude => _longitude;

  void startLocationUpdates() {
    _geoLocatorService.startListeningToLocationUpdates((Position position) {
      _currentPosition = position;
      _latitude = position.latitude;
      _longitude = position.longitude;
      notifyListeners();
    });
  }

  void stopLocationUpdates() {
    _geoLocatorService.stopListeningToLocationUpdates();
  }

  Future<void> getCurrentLocation() async {
    _currentPosition = await _geoLocatorService.determinePosition();
    if (_currentPosition != null) {
      _latitude = _currentPosition!.latitude;
      _longitude = _currentPosition!.longitude;
    }
    notifyListeners();
  }
}
