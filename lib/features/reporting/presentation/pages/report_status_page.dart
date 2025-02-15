import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import '../../../auth/presentation/states/auth.dart';
import '../../domain/report/report.dart';
import '../../domain/status/status.dart';
import '../states/report/report.dart';
import '../states/status_provider.dart';

class UserReportStatusPage extends ConsumerStatefulWidget {
  const UserReportStatusPage({super.key});

  @override
  ConsumerState<UserReportStatusPage> createState() =>
      _UserReportStatusPageState();
}

class _UserReportStatusPageState extends ConsumerState<UserReportStatusPage> {
  int selectedSegment = 1; // Valeur initiale (1 pour "En attente")

  @override
  void initState() {
    super.initState();
    ref.read(reportProvider.notifier).loadReports();
  }

  @override
  Widget build(BuildContext context) {
    final reportsAsyncValue = ref.watch(reportProvider);
    final statusesAsyncValue = ref.watch(statusProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mes ',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Longreach',
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(34),
              ),
              child: const Text(
                'signalements',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Longreach',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child:CustomSlidingSegmentedControl<int>(
              initialValue: selectedSegment,
              children: {
                1: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'En attente',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selectedSegment == 1 ? Colors.white : Colors.black, // Texte blanc si sélectionné
                      ),
                    ),
                  ),
                ),
                2: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4, // Largeur augmentée
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Confirmés',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selectedSegment == 2 ? Colors.white : Colors.black, // Texte blanc si sélectionné
                      ),
                    ),
                  ),
                ),
              },
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20), // Coins arrondis
              ),
              thumbDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(20), // Coins arrondis
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: const Offset(0.0, 2.0),
                  ),
                ],
              ),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInToLinear,
              onValueChanged: (value) {
                setState(() {
                  selectedSegment = value!;
                });
              },
            )


          ),
        ),
      ),
      body: _buildSegmentContent(reportsAsyncValue, statusesAsyncValue),
    );
  }

  Widget _buildSegmentContent(
      AsyncValue<List<Report>> reportsAsyncValue,
      AsyncValue<List<Status>> statusesAsyncValue,
      ) {
    if (selectedSegment == 1) {
      return _buildReportList(reportsAsyncValue, statusesAsyncValue, 'en_attente');
    } else if (selectedSegment == 2) {
      return _buildReportList(reportsAsyncValue, statusesAsyncValue, 'confirmed');
    } else {
      return const Center(child: Text("Aucune donnée à afficher"));
    }
  }

  Widget _buildReportList(
      AsyncValue<List<Report>> reportsAsyncValue,
      AsyncValue<List<Status>> statusesAsyncValue,
      String filterStatus,
      ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: reportsAsyncValue.when(
              data: (reports) {
                final userReports = reports
                    .where((report) =>
                report.user_id == ref.read(authProvider).uid &&
                    report.status_id != null)
                    .toList();

                if (userReports.isEmpty) {
                  return const Center(
                    child: Text(
                      "Aucun signalement trouvé.",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  );
                }

                return statusesAsyncValue.when(
                  data: (statuses) {
                    final filteredReports = userReports.where((report) {
                      final status = statuses.firstWhere(
                            (status) => status.id == report.status_id,
                        orElse: () => Status(id: 0, name: "inconnu"),
                      );
                      return status.name == filterStatus;
                    }).toList();

                    if (filteredReports.isEmpty) {
                      return const Center(
                        child: Text(
                          "Aucun signalement pour ce statut.",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredReports.length,
                      itemBuilder: (context, index) {
                        final report = filteredReports[index];
                        final statusName = statuses.firstWhere(
                              (status) => status.id == report.status_id,
                          orElse: () => Status(id: 0, name: "inconnu"),
                        ).name;

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: ListTile(
                            title: Text(
                              report.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  "Statut : $statusName",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.black),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Date : ${report.timestamp.toLocal()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(color: Colors.blueAccent),
                  ),
                  error: (error, stackTrace) => Center(
                    child: Text(
                      "Erreur lors du chargement des statuts : ${error.toString()}",
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(color: Colors.blueAccent),
              ),
              error: (error, stackTrace) => Center(
                child: Text(
                  "Erreur : ${error.toString()}",
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
