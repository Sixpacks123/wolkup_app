// map_notifier.dart
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

      Geolocator.getPositionStream().listen((Position position) {
        state = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print("Erreur lors de la récupération de la position : $e");
    }
  }

  Future<void> _checkPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Les services de localisation sont désactivés");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            "Les permissions de localisation sont refusées de manière permanente");
      }
      if (permission == LocationPermission.denied) {
        throw Exception("Les permissions de localisation sont refusées");
      }
    }
  }

  // Ajout de la méthode getCurrentPosition
  Future<LatLng?> getCurrentPosition() async {
    return state;
  }
}
