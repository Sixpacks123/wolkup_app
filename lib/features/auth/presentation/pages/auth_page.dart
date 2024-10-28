import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modular_ui/modular_ui.dart';
import 'auth_tabs.dart';
import 'login_form.dart';
import 'register_form.dart';

class AuthPage extends HookConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);

    void switchTab() {
      selectedIndex.value = selectedIndex.value == 0 ? 1 : 0;
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 60),

            // Logo de l'application
            Center(
              child: Image.asset(
                'assets/images/logo.png', // Chemin vers le logo
                height: 120,              // Taille ajustée pour une meilleure visibilité
              ),
            ),
            const SizedBox(height: 40), // Espace supplémentaire sous le logo

            // Onglets pour Login et Register
            MUITabs.underlined(
              tabIndex: selectedIndex.value,
              onChanged: (index) {
                selectedIndex.value = index;
              },
              tabs: [
                MUITab(label: "Login"),
                MUITab(label: "Register"),
              ],
            ),
            const SizedBox(height: 30), // Espacement supplémentaire pour un design épuré

            // Contenu dynamique basé sur l'onglet sélectionné
            Expanded(
              child: selectedIndex.value == 0
                  ? LoginForm(onSwitch: switchTab)
                  : RegisterForm(onSwitch: switchTab),
            ),
          ],
        ),
      ),
    );
  }
}
