// map_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/ui/widgets/user_marker.dart';
import 'poi.dart';

class MapView extends StatelessWidget {
  final MapController mapController;
  final LatLng initialCenter;
  final double initialZoom;
  final List<POI> pois; // List of Points of Interest markers
  final List<MarkerLayer> additionalLayers; // Dynamic additional layers for reports, etc.
  final void Function(dynamic, dynamic) onPositionChanged;

  const MapView({
    super.key,
    required this.mapController,
    required this.initialCenter,
    this.initialZoom = 13.0,
    required this.pois,
    required this.additionalLayers,
    required this.onPositionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: initialCenter,
        initialZoom: initialZoom,
        onPositionChanged: (position, hasGesture) =>
            onPositionChanged(position, hasGesture),
      ),
      children: [
        TileLayer(
          urlTemplate:
          'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
        ),
        // Consolidated MarkerLayer for user and POIs
        MarkerLayer(

          markers: [
            Marker(
              point: initialCenter,
              width: 30,
              height: 30,
              child: const Icon(Icons.my_location, color: Colors.blue),
            ),
            ...pois.map((poi) {
              return Marker(
                point: poi.location,
                width: 30,
                height: 30,
                child: Tooltip(
                  message: poi.name,
                  child: poi.icon,
                ),
              );
            }),
          ],
        ),
        // Additional layers for report markers and others
        ...additionalLayers,
      ],
    );
  }
}
