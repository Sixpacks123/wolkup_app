// map_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'poi.dart';

class MapView extends StatelessWidget {
  final MapController mapController;
  final LatLng initialCenter;
  final double initialZoom;
  final List<POI> pois; // Liste de POIs à afficher

  const MapView({
    super.key,
    required this.mapController,
    required this.initialCenter,
    this.initialZoom = 13.0,
    required this.pois,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: initialCenter,
        initialZoom: initialZoom,
      ),
      children: [
        TileLayer(
          urlTemplate:
          'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: [
            // Marqueur utilisateur
            Marker(
              point: initialCenter,
              width: 30,
              height: 30,
              child: const Icon(Icons.person, color: Colors.red),
            ),
            // Marqueurs POI
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
      ],
    );
  }
}
