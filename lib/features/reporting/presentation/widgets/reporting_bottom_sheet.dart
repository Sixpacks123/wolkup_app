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
  ConsumerState<ReportingBottomSheet> createState() =>
      _ReportingBottomSheetState();
}

class _ReportingBottomSheetState
    extends ConsumerState<ReportingBottomSheet> {
  final TextEditingController descriptionController =
  TextEditingController();
  final Set<String> selectedCategories = {};

  @override
  Widget build(BuildContext context) {
    final categoriesAsyncValue = ref.watch(categoryProvider);

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Texte personnalisé "Mes signalements"
          Row(
            children: [
              Text(
                'Sélectionnez ',
                style: TextStyle(
                  fontSize: 29,
                  fontFamily: 'Longreach',
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'une catégorie',
                  style: TextStyle(
                    fontSize: 29,
                    fontFamily: 'Longreach',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Affichage des catégories en grille
          SizedBox(
            height: 300,
            child: categoriesAsyncValue.when(
              data: (categories) => GridView.builder(
                itemCount: categories.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected =
                  selectedCategories.contains(category.id);

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
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
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
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              loading: () =>
              const Center(child: CircularProgressIndicator()),
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
            style: const TextStyle(color: Colors.transparent),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "Décrivez votre situation ou le(s) problème(s) rencontré(s)",

              hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
              labelText: "Décrivez votre situation ou le(s) problème(s) rencontré(s)",
              labelStyle: const TextStyle(color: Colors.black, fontSize: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary, width: 2),
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
                    widget.onReportSubmit(
                        categoryId, descriptionController.text);
                  }
                  Navigator.of(context).pop();
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
