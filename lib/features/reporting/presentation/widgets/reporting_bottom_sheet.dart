import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../states/category/category.dart';

class ReportingBottomSheet extends ConsumerStatefulWidget {
  final Function(String categoryId, String description) onReportSubmit;

  const ReportingBottomSheet({
    super.key,
    required this.onReportSubmit,
  });

  @override
  ConsumerState<ReportingBottomSheet> createState() => _ReportingBottomSheetState();
}

class _ReportingBottomSheetState extends ConsumerState<ReportingBottomSheet> {
  final TextEditingController descriptionController = TextEditingController();
  final Set<String> selectedCategories = {}; // Utilise des UUID de type String pour les catégories sélectionnées

  @override
  Widget build(BuildContext context) {
    final categoriesAsyncValue = ref.watch(categoryProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Sélectionnez une catégorie",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),

          // Affichage des catégories en grille
          SizedBox(
            height: 500, // Limite la hauteur de la grille
            child: categoriesAsyncValue.when(
              data: (categories) => GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategories.contains(category.id);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedCategories.remove(category.id);
                        } else {
                          selectedCategories.add(category.id);
                        }
                      });
                    },
                    child: Card(
                      color: isSelected ? Colors.blueAccent : Colors.white,
                      elevation: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (category.iconUrl != null)
                            Image.network(category.iconUrl!, height: 20),
                          const SizedBox(height: 4),
                          Text(category.name, textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text("Erreur: ${error.toString()}"),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Champ de description
          TextField(
            controller: descriptionController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: "Décrivez le problème",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          // Bouton de soumission
          ElevatedButton(
            onPressed: () {
              if (descriptionController.text.isNotEmpty && selectedCategories.isNotEmpty) {
                // Envoie un signalement pour chaque catégorie sélectionnée
                for (var categoryId in selectedCategories) {
                  widget.onReportSubmit(categoryId, descriptionController.text);
                }
                Navigator.of(context).pop(); // Ferme le BottomSheet après soumission
              }
            },
            child: const Text("Soumettre le signalement"),
          ),
        ],
      ),
    );
  }
}
