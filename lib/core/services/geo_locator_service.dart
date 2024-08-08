import 'dart:async';
import 'package:geolocator/geolocator.dart';

class GeoLocatorService {
  Future<Position?> determinePosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Future.delayed(const Duration(seconds: 2));
        return determinePosition();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getCurrentLocation() async {
    try {
      Position? position = await determinePosition();
      if (position != null) {
      } else {}
    } catch (e) {
      throw Exception('Error al obtener el la ubicacion: $e');
    }
  }

  StreamSubscription<Position>? _positionStreamSubscription;

  void startListeningToLocationUpdates(Function(Position) onPositionChanged) {
    _positionStreamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      onPositionChanged(position);
    });
  }

  void stopListeningToLocationUpdates() {
    _positionStreamSubscription?.cancel();
  }
}
