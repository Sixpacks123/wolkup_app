import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpendWolksPage extends ConsumerStatefulWidget {
  const SpendWolksPage({super.key});

  @override
  ConsumerState<SpendWolksPage> createState() => _SpendWolksPageState();
}

class _SpendWolksPageState extends ConsumerState<SpendWolksPage> {
  String selectedTab = 'Tout';

  // Exemple de données statiques
  final List<Map<String, dynamic>> allRewards = [
    {'title': '50 € offert', 'subtitle': 'Super U', 'points': 50, 'status': 'Disponibles', 'category': 'Promotions'},
    {'title': '20 % de réduction', 'subtitle': 'Jardiland', 'points': 50, 'status': 'Disponibles', 'category': 'Promotions'},
    {'title': '10 € offert', 'subtitle': 'Carrefour City', 'points': 50, 'status': 'Terminés', 'category': 'Commerces locaux'},
    {'title': '15 % de réduction', 'subtitle': 'L\'atelier du cordonnier', 'points': 50, 'status': 'À venir', 'category': 'Commerces locaux'},
    {'title': 'Faire un don', 'subtitle': 'La Croix Rouge', 'points': 50, 'status': 'Disponibles', 'category': 'Solidarité'},
    {'title': 'Faire un don', 'subtitle': 'Les Restos du Cœur', 'points': 50, 'status': 'Terminés', 'category': 'Solidarité'},
  ];

  // Filtre les récompenses par statut et catégorie
  List<Map<String, dynamic>> getFilteredRewards(String category) {
    final filteredRewards = selectedTab == 'Tout'
        ? allRewards
        : allRewards.where((reward) => reward['status'] == selectedTab).toList();
    return filteredRewards.where((reward) => reward['category'] == category).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title:
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Dépensez vos Wolks',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.white,
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                  '3445 ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Image(image: AssetImage('assets/images/wolks.png'), height: 24),
              ],
            ),
          ],
        ),
        ),

        centerTitle: true,
      ),
      body: Column(
        children: [
          // Onglets
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTab(context, 'Tout', isSelected: selectedTab == 'Tout'),
                _buildTab(context, 'Disponibles',
                    isSelected: selectedTab == 'Disponibles'),
                _buildTab(context, 'À venir',
                    isSelected: selectedTab == 'À venir'),
                _buildTab(context, 'Terminés',
                    isSelected: selectedTab == 'Terminés'),
              ],
            ),
          ),

          // Contenu
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Promotions
                  _buildSection(
                    context,
                    'Promotions',
                    items: getFilteredRewards('Promotions'),
                  ),

                  // Section Commerces locaux
                  _buildSection(
                    context,
                    'Commerces locaux',
                    items: getFilteredRewards('Commerces locaux'),
                  ),

                  // Section Solidarité
                  _buildSection(
                    context,
                    'Solidarité',
                    items: getFilteredRewards('Solidarité'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, String label,
      {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = label;
        });
      },
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title,
      {required List<Map<String, dynamic>> items}) {
    if (items.isEmpty) {
      return const SizedBox.shrink(); // Ne rien afficher si la section est vide
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre de la section et bouton "Plus"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Text(
                'Plus',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Cartes de la section
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: items
                    .map(
                      (reward) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: _buildCard(
                      reward['title'],
                      reward['subtitle'],
                      reward['points'],
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String subtitle, int points) {
    return Container(
      width: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ligne pour remplacer les images
          Container(
            height: 100,
            width: double.infinity,
            color: Colors.grey[300],
            child: Center(
              child: Text(
                'Image',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),

          // Contenu texte
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '$points',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(
                      Icons.monetization_on,
                      color: Colors.amber,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
