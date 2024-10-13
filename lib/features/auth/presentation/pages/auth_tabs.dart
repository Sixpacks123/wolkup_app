import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modular_ui/modular_ui.dart';

class AuthTabs extends StatelessWidget {
  final int initialIndex;

  const AuthTabs({Key? key, required this.initialIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> tabIndexNotifier = ValueNotifier(initialIndex);

    return ValueListenableBuilder<int>(
      valueListenable: tabIndexNotifier,
      builder: (context, tabIndex, child) {
        return Container(
          width: double.infinity, // Ensure full width
          child: MUITabs.underlined(
            tabIndex: tabIndex,
            onChanged: (index) {
              tabIndexNotifier.value = index;
              if (index == 0) {
                context.go('/login'); // Navigate to Login page
              } else {
                context.go('/register'); // Navigate to Register page
              }
            },
            tabs: [
              MUITab(label: "Login"),
              MUITab(label: "Register"),
            ],
          ),
        );
      },
    );
  }
}
