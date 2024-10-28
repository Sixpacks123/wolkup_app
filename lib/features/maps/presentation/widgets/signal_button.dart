// signal_button.dart
import 'package:flutter/material.dart';

class SignalButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignalButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.red,
      child: const Icon(Icons.add_alert),
    );
  }
}
