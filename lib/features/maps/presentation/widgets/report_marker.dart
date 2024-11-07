import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../../reporting/presentation/states/report/report.dart';

class ReportMarkers extends ConsumerWidget {
  final MapController mapController;

  const ReportMarkers({super.key, required this.mapController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportState = ref.watch(reportProvider);

    return reportState.when(
      data: (reports) {
        return MarkerLayer(
          markers: reports.map((report) {
            return Marker(
              width: 40.0,
              height: 40.0,
              point: LatLng(report.latitude, report.longitude),
              child: const Icon(Icons.location_on, color: Colors.red,size: 40,),
            );
          }).toList(),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
