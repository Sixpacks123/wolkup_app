import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'map_notifier.dart';

final mapStateProvider = StateNotifierProvider<MapNotifier, LatLng?>((ref) {
  return MapNotifier();
});
