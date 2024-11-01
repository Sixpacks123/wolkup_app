import 'package:flutter/material.dart';

class AuthTabs extends StatelessWidget {
  final ValueNotifier<int> selectedIndex;
  final ValueChanged<int> onTabChanged;

  const AuthTabs({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: const [
        Tab(text: "Login"),
        Tab(text: "Register"),
      ],
      onTap: onTabChanged,
    );
  }
}
