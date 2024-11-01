import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wolkup_app/core/resources/lib/supabase.dart';
import '../../../domain/category/category.dart';

final categoryProvider = StateNotifierProvider<CategoryNotifier, AsyncValue<List<Category>>>((ref) {
  return CategoryNotifier();
});

class CategoryNotifier extends StateNotifier<AsyncValue<List<Category>>> {
  CategoryNotifier() : super(const AsyncValue.loading()) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      final response = await supabase.from('category').select(); // Pas de limitation dans la requête

      print('Données récupérées de Supabase : $response'); // Log pour déboguer

      // Convertit les données en liste de Category
      final categories = (response as List<dynamic>).map((json) => Category.fromJson(json)).toList();
      state = AsyncValue.data(categories);
    } catch (error, stackTrace) {
      print('Erreur lors de la récupération des catégories : $error'); // Log pour l'erreur
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
