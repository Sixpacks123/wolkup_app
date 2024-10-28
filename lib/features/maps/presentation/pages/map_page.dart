// map_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:wolkup_app/features/maps/presentation/states/map_state_provider.dart';
import 'package:wolkup_app/features/maps/presentation/widgets/center_location_button.dart';
import 'package:wolkup_app/features/maps/presentation/widgets/signal_button.dart';
import 'package:wolkup_app/features/maps/presentation/widgets/map_view.dart';

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
    _setInitialPosition();
  }

  Future<void> _setInitialPosition() async {
    final initialPosition =
    await ref.read(mapStateProvider.notifier).getCurrentPosition();
    if (initialPosition != null) {
      _mapController.move(initialPosition, 13);
    }
  }

  void _centerMapOnUser() {
    final userPosition = ref.read(mapStateProvider);
    if (userPosition != null) {
      _mapController.move(userPosition, 13);
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
          MapView(
            mapController: _mapController,
            initialCenter: currentPosition,
            initialZoom: 13.0,
          ),
          Positioned(
            bottom: 80,
            right: 16,
            child: CenterLocationButton(onPressed: _centerMapOnUser),
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
