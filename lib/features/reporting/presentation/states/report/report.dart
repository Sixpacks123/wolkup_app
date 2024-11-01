import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/resources/lib/supabase.dart';
import '../../../domain/report/report.dart';

final reportProvider = StateNotifierProvider<ReportNotifier, AsyncValue<List<Report>>>((ref) {
  return ReportNotifier();
});

class ReportNotifier extends StateNotifier<AsyncValue<List<Report>>> {
  ReportNotifier() : super(const AsyncValue.loading());

  Future<void> loadReports() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception("Utilisateur non connecté.");
      }

      final response = await supabase
          .from('reports')
          .select()
          .eq('user_id', userId);

      final reports = (response as List<dynamic>).map((json) => Report.fromJson(json)).toList();
      state = AsyncValue.data(reports);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<String?> createReport(Report report) async {
    try {
      final reportData = report.toJson()
        ..remove('id')
        ..remove('status_id');

      final response = await supabase
          .from('reports')
          .insert(reportData)  // Envoie le JSON sans 'id'
          .select();

      if (response.isNotEmpty) {
        final newReport = Report.fromJson(response[0]);
        state = AsyncValue.data([...state.value ?? [], newReport]);
        return null; // Succès, aucune erreur
      } else {
        return "Erreur : aucune donnée de rapport insérée.";
      }
    } catch (error) {
      return error.toString(); // Retourne le message d'erreur en cas d'échec
    }
  }



}
