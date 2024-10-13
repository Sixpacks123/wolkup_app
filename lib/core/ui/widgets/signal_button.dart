import 'package:flutter/material.dart';

class SignalButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignalButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.red,
      child: const Icon(Icons.report_problem, color: Colors.white),
    );
  }
}
