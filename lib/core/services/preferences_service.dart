import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesServicesBase {
  final SharedPreferences prefs;

  PreferencesServicesBase({required this.prefs});

  Future<void> deleteEntity(String key);

  Future<void> saveCoordinates(double latitude, double longitude);
  Future<Map<String, double>?> getCoordinates();
  Future<void> clearAllPreferences();
}

class PreferencesServices extends PreferencesServicesBase {
  PreferencesServices({required super.prefs});

  @override
  Future<void> deleteEntity(String key) async {
    await prefs.remove(key);
  }

  @override
  Future<void> saveCoordinates(double latitude, double longitude) async {
    final coordinates = jsonEncode({
      'latitude': latitude,
      'longitude': longitude,
    });
    await prefs.setString('coordinates', coordinates);
  }

  @override
  Future<Map<String, double>?> getCoordinates() async {
    final coordinates = prefs.getString('coordinates');
    if (coordinates != null) {
      final Map<String, dynamic> decoded = jsonDecode(coordinates);
      return {
        'latitude': decoded['latitude'],
        'longitude': decoded['longitude'],
      };
    }
    return null;
  }

  @override
  Future<void> clearAllPreferences() async {
    await prefs.clear();
  }
}
