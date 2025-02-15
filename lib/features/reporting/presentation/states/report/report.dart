import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/resources/lib/supabase.dart';
import '../../../domain/report/report.dart';

final reportProvider = StateNotifierProvider<ReportNotifier, AsyncValue<List<Report>>>((ref) {
  return ReportNotifier();
});

class ReportNotifier extends StateNotifier<AsyncValue<List<Report>>> {
  ReportNotifier() : super(const AsyncValue.loading());

  /// Charge les rapports pour l'utilisateur connecté
  Future<void> loadReports({int offset = 0, int limit = 10}) async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception("Utilisateur non connecté.");
      }

      final response = await supabase
          .from('reports')
          .select()
          .eq('user_id', userId)
          .range(offset, offset + limit - 1);

      final reports = (response as List<dynamic>).map((json) => Report.fromJson(json)).toList();

      if (offset == 0) {
        // Si offset est 0, remplacer les rapports existants
        state = AsyncValue.data(reports);
      } else {
        // Ajouter les nouveaux rapports aux existants
        state = AsyncValue.data([...state.value ?? [], ...reports]);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Crée un nouveau rapport et l'ajoute à l'état
  Future<String?> createReport(Report report) async {
    try {
      final reportData = report.toJson()
        ..remove('id')
        ..remove('status_id'); // Supprimer les champs inutiles avant l'insertion

      final response = await supabase
          .from('reports')
          .insert(reportData)
          .select();

      if (response.isNotEmpty) {
        final newReport = Report.fromJson(response[0]);
        state = AsyncValue.data([...state.value ?? [], newReport]);
        return null; // Succès
      } else {
        return "Erreur : aucune donnée de rapport insérée.";
      }
    } catch (error) {
      return error.toString(); // Retourner le message d'erreur
    }
  }

  /// Met à jour un rapport existant et actualise l'état
  Future<String?> updateReport(Report report) async {
    try {
      final response = await supabase
          .from('reports')
          .update(report.toJson())
          .eq('id', report.id as Object);

      if (response.isNotEmpty) {
        final updatedReports = state.value?.map((r) {
          return r.id == report.id ? Report.fromJson(response[0]) : r;
        }).toList();
        state = AsyncValue.data(updatedReports ?? []);
        return null; // Succès
      } else {
        return "Erreur : aucune mise à jour effectuée.";
      }
    } catch (error) {
      return error.toString(); // Retourner le message d'erreur
    }
  }

  /// Supprime un rapport existant et actualise l'état
  Future<String?> deleteReport(String reportId) async {
    try {
      final response = await supabase
          .from('reports')
          .delete()
          .eq('id', reportId);

      if (response.isNotEmpty) {
        final updatedReports = state.value?.where((r) => r.id != reportId).toList();
        state = AsyncValue.data(updatedReports ?? []);
        return null; // Succès
      } else {
        return "Erreur : aucune suppression effectuée.";
      }
    } catch (error) {
      return error.toString(); // Retourner le message d'erreur
    }
  }
}
