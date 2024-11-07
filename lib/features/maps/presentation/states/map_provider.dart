// map_provider.dart

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapProvider extends StateNotifier<LatLng?> {
  bool _isUserMovingMap = false;

  MapProvider() : super(null) {
    _initializePosition();
  }

  Future<void> _initializePosition() async {
    try {
      await _checkPermissions();
      Position position = await Geolocator.getCurrentPosition();
      state = LatLng(position.latitude, position.longitude);

      Geolocator.getPositionStream().listen((Position position) {
        if (!_isUserMovingMap) {
          // Only update position if the user is not actively moving the map
          state = LatLng(position.latitude, position.longitude);
        }
      });
    } catch (e) {
      print("Error initializing position: $e");
      state = null;
    }
  }

  Future<void> _checkPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        throw Exception("Location permissions are permanently denied.");
      }
      if (permission == LocationPermission.denied) {
        throw Exception("Location permissions are denied.");
      }
    }
  }

  Future<void> centerMapOnUser(MapController mapController) async {
    if (state != null) {
      mapController.move(state!, 13);
      _isUserMovingMap = false; // Reset the flag to allow automatic updates
    } else {
      print("User position not available.");
    }
  }

  // Method to indicate user has manually moved the map
  void onMapMove() {
    _isUserMovingMap = true;
  }

  Future<LatLng?> getCurrentPosition() async {
    return state;
  }
}

// Define the provider
final mapStateProvider = StateNotifierProvider<MapProvider, LatLng?>((ref) {
  return MapProvider();
});
