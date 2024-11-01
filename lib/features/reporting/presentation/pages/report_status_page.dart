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
    ref.read(reportProvider.notifier).loadReports();
  }

  @override
  Widget build(BuildContext context) {
    final reportsAsyncValue = ref.watch(reportProvider);
    final statusesAsyncValue = ref.watch(statusProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes Signalements", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent, // AppBar transparente pour se fondre avec le thème noir
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: reportsAsyncValue.when(
          data: (reports) {
            final userReports = reports
                .where((report) => report.user_id == ref.read(authProvider).uid)
                .toList();

            if (userReports.isEmpty) {
              return const Center(
                child: Text(
                  "Aucun signalement trouvé.",
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            return statusesAsyncValue.when(
              data: (statuses) {
                return ListView.builder(
                  itemCount: userReports.length,
                  itemBuilder: (context, index) {
                    final report = userReports[index];
                    final statusName = statuses
                        .firstWhere((status) => status.id == report.status_id)
                        .name;

                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        tileColor: Colors.grey[850], // Fond plus sombre dans les cartes pour un léger contraste
                        title: Text(
                          report.description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              "Status: $statusName",
                              style: TextStyle(
                                color: Colors.blueAccent[100],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Date: ${report.timestamp.toLocal()}",
                              style: const TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text(
                  "Erreur lors du chargement des statuts: ${error.toString()}",
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text(
              "Erreur: ${error.toString()}",
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        ),
      ),
    );
  }
}
