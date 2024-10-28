// map_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatelessWidget {
  final MapController mapController;
  final LatLng initialCenter;
  final double initialZoom;

  const MapView({
    Key? key,
    required this.mapController,
    required this.initialCenter,
    this.initialZoom = 13.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: initialCenter,  // Utilisez initialCenter pour définir la position initiale
        initialZoom: initialZoom,      // Utilisez initialZoom pour définir le niveau de zoom initial
        onTap: (tapPosition, point) {
          debugPrint('Tapped at: ${point.latitude}, ${point.longitude}');
        },
      ),
      children: [
        TileLayer(
          urlTemplate:
          'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: initialCenter, // Marqueur à la position initiale
              width: 30,
              height: 30,
              child: const Icon(Icons.location_on, size: 30),
            ),
          ],
        ),
      ],
    );
  }
}
