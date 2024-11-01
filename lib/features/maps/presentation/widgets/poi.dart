// poi.dart
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

class POI {
  final LatLng location;
  final String name;
  final Icon icon;

  POI({
    required this.location,
    required this.name,
    required this.icon,
  });
}
