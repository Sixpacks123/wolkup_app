// features/maps/presentation/pages/map_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:wolkup_app/features/maps/presentation/states/map_state.dart';
import 'package:wolkup_app/core/ui/widgets/signal_button.dart';

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
    _setCurrentPosition(); // Récupérer la position de l'utilisateur au démarrage
  }

  Future<void> _setCurrentPosition() async {
    // Lire l'état de la position de l'utilisateur à partir du MapNotifier
    final currentPosition =
        await ref.read(mapStateProvider.notifier).getCurrentPosition();
    if (currentPosition != null) {
      _mapController.move(currentPosition, 13); // Centrer la carte
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentPosition = ref.watch(mapStateProvider);

    return Scaffold(
      body: currentPosition == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
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
                          'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                  ],
                ),
                // Utiliser un widget placé au centre pour le marqueur de l'utilisateur
                const Center(
                  child: Icon(
                    Icons.circle,
                    color: Colors.blue,
                    size: 16,
                  ),
                ),
                // Position du bouton de signalement
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
