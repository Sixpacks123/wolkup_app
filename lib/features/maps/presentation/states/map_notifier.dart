import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapNotifier extends StateNotifier<LatLng?> {
  MapNotifier() : super(null) {
    _initializePosition();
  }

  Future<void> _initializePosition() async {
    try {
      await _checkPermissions();
      Position position = await Geolocator.getCurrentPosition();
      state = LatLng(position.latitude, position.longitude);
      print("Position initialized: $state");

      // Écouter les mises à jour de la position
      Geolocator.getPositionStream().listen((Position position) {
        state = LatLng(position.latitude, position.longitude);
        print("Position updated: $state");
      });
    } catch (e) {
      print("Error initializing position: $e");
      state = null; // Réinitialiser à null en cas d'erreur
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

  Future<LatLng?> getCurrentPosition() async {
    return state;
  }
}
