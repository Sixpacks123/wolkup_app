import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class UserMarker extends StatelessWidget {
  final LatLng position;

  const UserMarker({Key? key, required this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        Marker(
          point: position,
          width: 40,
          height: 40,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.7),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.person_pin_circle,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
