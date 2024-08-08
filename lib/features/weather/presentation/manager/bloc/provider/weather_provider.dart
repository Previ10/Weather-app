import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/services/geo_locator_service.dart';

class GeoLocatorProvider extends ChangeNotifier {
  final GeoLocatorService _geoLocatorService = GeoLocatorService();
  Position? _currentPosition;
  double? _latitude;
  double? _longitude;
  bool _isLoading = false;
  String? _errorMessage;

  Position? get currentPosition => _currentPosition;
  double? get latitude => _latitude;
  double? get longitude => _longitude;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

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
    _isLoading = true;
    notifyListeners();
    try {
      _currentPosition = await _geoLocatorService.determinePosition();
      if (_currentPosition != null) {
        _latitude = _currentPosition!.latitude;
        _longitude = _currentPosition!.longitude;
        _errorMessage = null;
      } else {
        _errorMessage = 'No se pudo obtener la ubicación.';
      }
    } catch (e) {
      _errorMessage = 'Error al obtener la ubicación: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
