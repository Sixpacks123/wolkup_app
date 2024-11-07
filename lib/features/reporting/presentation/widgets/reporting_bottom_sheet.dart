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
  final Set<String> selectedCategories = {};

  @override
  Widget build(BuildContext context) {
    final categoriesAsyncValue = ref.watch(categoryProvider);

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -4), // décalage de l'ombre pour un effet subtil
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Sélectionnez une catégorie",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith( fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Affichage des catégories en grille
          SizedBox(
            height: 300, // Limite la hauteur de la grille
            child: categoriesAsyncValue.when(
              data: (categories) => GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.5,
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
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: isSelected ?Theme.of(context).colorScheme.primary : Colors.grey[800],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (category.iconUrl != null)
                            Image.network(category.iconUrl!, height: 20),
                          const SizedBox(height: 4),
                          Text(
                            category.name,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text(
                  "Erreur: ${error.toString()}",
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Champ de description
          TextField(
            controller: descriptionController,
            maxLines: 4,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[850],
              hintText: "Décrivez le problème",
              hintStyle: const TextStyle(color: Colors.grey),
              labelText: "Description",
              labelStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:  BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Bouton de soumission
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (descriptionController.text.isNotEmpty &&
                    selectedCategories.isNotEmpty) {
                  for (var categoryId in selectedCategories) {
                    widget.onReportSubmit(categoryId, descriptionController.text);
                  }
                  Navigator.of(context).pop(); // Ferme le BottomSheet après soumission
                }
              },
              child: const Text(
                "Soumettre le signalement",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
