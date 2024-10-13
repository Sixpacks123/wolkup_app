// features/maps/presentation/states/map_state.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

final mapStateProvider = StateNotifierProvider<MapNotifier, LatLng?>((ref) {
  return MapNotifier();
});

class MapNotifier extends StateNotifier<LatLng?> {
  MapNotifier() : super(null) {
    _determinePosition();
  }

  Future<LatLng?> getCurrentPosition() async {
    return state;
  }

  Future<void> _determinePosition() async {
    try {
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

      Position position = await Geolocator.getCurrentPosition();
      state = LatLng(position.latitude, position.longitude);
    } catch (e) {
      print("Erreur lors de la récupération de la position : $e");
    }
  }
}
