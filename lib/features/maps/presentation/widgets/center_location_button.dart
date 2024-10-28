// center_location_button.dart
import 'package:flutter/material.dart';

class CenterLocationButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CenterLocationButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.blue,
      child: const Icon(Icons.my_location),
    );
  }
}
