import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/states/auth.dart';
import '../states/report/report.dart';
import '../states/status_provider.dart';

class UserReportStatusPage extends ConsumerStatefulWidget {
  const UserReportStatusPage({super.key});

  @override
  ConsumerState<UserReportStatusPage> createState() => _UserReportStatusPageState();
}

class _UserReportStatusPageState extends ConsumerState<UserReportStatusPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Charger les rapports lorsque la page est affichée
    ref.read(reportProvider.notifier).loadReports();
  }

  @override
  Widget build(BuildContext context) {
    final reportsAsyncValue = ref.watch(reportProvider);
    final statusesAsyncValue = ref.watch(statusProvider); // Charger les statuts

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes Signalements"),
      ),
      body: reportsAsyncValue.when(
        data: (reports) {
          final userReports = reports.where((report) => report.user_id == ref.read(authProvider).uid).toList();

          if (userReports.isEmpty) {
            return const Center(child: Text("Aucun signalement trouvé."));
          }

          return statusesAsyncValue.when(
            data: (statuses) {
              return ListView.builder(
                itemCount: userReports.length,
                itemBuilder: (context, index) {
                  final report = userReports[index];
                  final statusName = statuses
                      .firstWhere((status) => status.id == report.status_id)
                      .name; // Associe le status_id avec le nom

                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(report.description),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Status: $statusName"), // Affiche le nom du statut
                          Text("Date: ${report.timestamp.toLocal()}"),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text("Erreur lors du chargement des statuts: ${error.toString()}"),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text("Erreur: ${error.toString()}"),
        ),
      ),
    );
  }
}
