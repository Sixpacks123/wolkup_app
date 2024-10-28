// map_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:wolkup_app/features/maps/presentation/states/map_state_provider.dart';
import 'package:wolkup_app/features/maps/presentation/widgets/signal_button.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _setInitialPosition(); // Centre la carte sur la position actuelle
  }

  Future<void> _setInitialPosition() async {
    final initialPosition =
    await ref.read(mapStateProvider.notifier).getCurrentPosition();
    if (initialPosition != null) {
      _mapController.move(initialPosition, 13); // Centrer la carte initialement
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentPosition = ref.watch(mapStateProvider);

    return Scaffold(
      body: currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: currentPosition,
              initialZoom: 13,
              onTap: (tapPosition, point) {
                debugPrint(
                    'Tapped at: ${point.latitude}, ${point.longitude}');
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
                    point: currentPosition,
                    width: 30, // Largeur du marqueur
                    height: 30, // Hauteur du marqueur
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: SignalButton(
              onPressed: () {
                debugPrint('Bouton de signalement pressé');
              },
            ),
          ),
        ],
      ),
    );
  }
}
