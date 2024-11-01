// poi_data.dart
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'poi.dart';

final List<POI> monuments = [
  POI(
    location: LatLng(48.8584, 2.2945), // Exemple: Tour Eiffel
    name: 'Tour Eiffel',
    icon: const Icon(Icons.account_balance, color: Colors.blue),
  ),
];

final List<POI> trashCans = [
  POI(
    location: const LatLng(48.8606, 2.3376),
    name: 'Poubelle Louvre',
    icon: const Icon(Icons.delete, color: Colors.green),
  ),
  // Ajoutez d'autres poubelles
];

final List<POI> parks = [
  POI(
    location: const LatLng(48.8566, 2.3522), // Exemple: Jardin des Tuileries
    name: 'Jardin des Tuileries',
    icon: const Icon(Icons.park, color: Colors.green),
  ),
];
