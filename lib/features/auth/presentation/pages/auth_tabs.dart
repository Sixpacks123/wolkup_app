import 'package:flutter/material.dart';
import 'package:modular_ui/modular_ui.dart';

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
    return MUITabs.underlined(
      tabIndex: selectedIndex.value,
      onChanged: onTabChanged,
      tabs: [
        MUITab(label: "Login"),
        MUITab(label: "Register"),
      ],
    );
  }
}
