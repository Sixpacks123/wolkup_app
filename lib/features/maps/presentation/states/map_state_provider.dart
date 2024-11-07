import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'map_provider.dart';

final mapStateProvider = StateNotifierProvider<MapProvider, LatLng?>((ref) {
  return MapProvider();
});
