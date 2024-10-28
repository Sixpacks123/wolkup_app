// user_marker.dart
import 'package:flutter/material.dart';

class UserMarker extends StatelessWidget {
  const UserMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.circle,
        color: Colors.blue,
        size: 16,
      ),
    );
  }
}
