import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:wolkup_app/features/maps/presentation/states/map_state_provider.dart';
import 'package:wolkup_app/features/maps/presentation/widgets/center_location_button.dart';
import 'package:wolkup_app/features/maps/presentation/widgets/signal_button.dart';
import 'package:wolkup_app/features/maps/presentation/widgets/map_view.dart';
import 'package:wolkup_app/features/maps/presentation/widgets/bubble_marker.dart';
import 'package:wolkup_app/features/reporting/presentation/widgets/reporting_bottom_sheet.dart';
import '../../../auth/presentation/states/auth.dart';
import '../../../reporting/domain/category/category.dart';
import '../../../reporting/domain/report/report.dart';
import '../../../reporting/presentation/states/report/report.dart';
import '../../../reporting/presentation/states/category/category.dart';
import '../../../reporting/presentation/widgets/ReportDetailsBottomSheet.dart';
import '../widgets/poi_data.dart';

class MapPage extends ConsumerWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapController = MapController();
    final currentPosition = ref.watch(mapStateProvider);
    final reportState = ref.watch(reportProvider);
    final categoryState = ref.watch(categoryProvider);

    // Function to open the report details bottom sheet
    void openReportBottomSheet(Report report) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) => ReportDetailsBottomSheet(report: report), // Use report here
      );
    }

    return Scaffold(
      body: currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          FutureBuilder(
            future: Future.delayed(
              Duration.zero,
                  () => mapController.move(currentPosition, 13.0),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }

              if (categoryState is AsyncData<List<Category>> &&
                  reportState is AsyncData<List<Report>>) {
                return MapView(
                  mapController: mapController,
                  initialCenter: currentPosition,
                  initialZoom: 13.0,
                  pois: [...monuments, ...trashCans, ...parks],
                  onPositionChanged: (position, hasGesture) {
                    if (hasGesture == true) {
                      ref.read(mapStateProvider.notifier).onMapMove();
                    }
                  },
                  additionalLayers: [
                    MarkerLayer(
                      markers: reportState.value.map((report) {
                        final category = categoryState.value.firstWhere(
                              (cat) => cat.id == report.category_id,
                          orElse: () => const Category(id: '', name: '', iconUrl: null),
                        );
                        return Marker(
                          point: LatLng(report.latitude, report.longitude),
                          width: 80.0,
                          height: 60.0,
                          child: BubbleMarker(
                            categoryIconUrl: category.iconUrl ?? '',
                            description: report.description,
                            onTap: () => openReportBottomSheet(report), // Open bottom sheet on tap
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            bottom: 80,
            right: 16,
            child: CenterLocationButton(
              onPressed: () {
                ref.read(mapStateProvider.notifier).centerMapOnUser(mapController);
              },
            ),
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
                    onReportSubmit: (categoryId, description) async {
                      final position = await ref.read(mapStateProvider.notifier).getCurrentPosition();
                      if (position != null) {
                        final report = Report(
                          user_id: ref.read(authProvider).uid,
                          category_id: categoryId,
                          description: description,
                          latitude: position.latitude,
                          longitude: position.longitude,
                          timestamp: DateTime.now(),
                        );

                        final error = await ref.read(reportProvider.notifier).createReport(report);
                        if (error != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Erreur : $error")),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Signalement créé avec succès !")),
                          );
                          ref.read(reportProvider.notifier).loadReports();
                        }
                      } else {
                        print("Current position is null, cannot submit report.");
                      }
                    },
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
