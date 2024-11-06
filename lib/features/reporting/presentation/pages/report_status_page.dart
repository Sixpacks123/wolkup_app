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
      extendBodyBehindAppBar: true, // Permet au fond d'aller derrière l'AppBar
      body: Container(
        decoration:   BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Theme.of(context).colorScheme.shadow, Colors.black],
          ),
        ),
        child: Padding(
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
                    style: TextStyle(color: Colors.white70, fontSize: 16),
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
                        elevation: 6,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.grey[900],
                        child: ListTile(
                          leading: Icon(
                            Icons.report,
                            color: Theme.of(context).colorScheme.primary,
                            size: 30,
                          ),
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
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Date: ${report.timestamp.toLocal()}",
                                style: const TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          trailing: const Icon(
                            Icons.chevron_right,
                            color: Colors.white70,
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator(color: Colors.blueAccent)),
                error: (error, stack) => Center(
                  child: Text(
                    "Erreur lors du chargement des statuts: ${error.toString()}",
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator(color: Colors.blueAccent)),
            error: (error, stack) => Center(
              child: Text(
                "Erreur: ${error.toString()}",
                style: const TextStyle(color: Colors.redAccent),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
