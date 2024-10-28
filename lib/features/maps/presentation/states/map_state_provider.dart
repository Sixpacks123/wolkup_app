// map_state_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wolkup_app/features/maps/presentation/states/map_notifier.dart';
import 'package:latlong2/latlong.dart';

final mapStateProvider = StateNotifierProvider<MapNotifier, LatLng?>((ref) {
  return MapNotifier();
});
