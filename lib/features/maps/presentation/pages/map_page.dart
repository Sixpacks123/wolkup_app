import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:wolkup_app/features/maps/presentation/states/map_state_provider.dart';
import 'package:wolkup_app/features/maps/presentation/widgets/center_location_button.dart';
import 'package:wolkup_app/features/maps/presentation/widgets/signal_button.dart';
import 'package:wolkup_app/features/maps/presentation/widgets/map_view.dart';
import 'package:wolkup_app/features/reporting/presentation/widgets/reporting_bottom_sheet.dart';
import '../../../auth/presentation/states/auth.dart';
import '../../../reporting/domain/report/report.dart';
import '../../../reporting/presentation/states/report/report.dart';
import '../widgets/poi_data.dart';

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
    try {
      final initialPosition = await ref.read(mapStateProvider.notifier).getCurrentPosition();
      print("Initial position retrieved: $initialPosition");
      if (mounted && initialPosition != null) {
        _mapController.move(initialPosition, 13);
        print("Map controller moved to: $initialPosition");
      } else {
        print("Initial position is null.");
      }
    } catch (e) {
      print("Error in _setInitialPosition: $e");
    }
  }


  void _centerMapOnUser() {
    final userPosition = ref.read(mapStateProvider);
    if (userPosition != null) {
      _mapController.move(userPosition, 13);
      print("Map centered on user position: $userPosition");
    } else {
      print("User position is null, cannot center map.");
    }
  }

  Future<void> _submitReport(String category_id, String description) async {
    final currentPosition = ref.read(mapStateProvider);
    if (currentPosition != null) {
      final report = Report(
        user_id: ref.read(authProvider).uid,
        category_id: category_id,
        description: description,
        latitude: currentPosition.latitude,
        longitude: currentPosition.longitude,
        timestamp: DateTime.now(),
      );

      print("Submitting report: $report");

      final error = await ref.read(reportProvider.notifier).createReport(report);
      if (mounted) {
        if (error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erreur : $error")),
          );
          print("Error while submitting report: $error");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Signalement créé avec succès !")),
          );
          print("Report submitted successfully.");
        }
      }
    } else {
      print("Current position is null, cannot submit report.");
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
            pois: [...monuments, ...trashCans, ...parks],
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
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (_) => ReportingBottomSheet(
                    onReportSubmit: _submitReport,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
