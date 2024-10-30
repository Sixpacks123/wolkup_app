import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../form/login_form.dart';
import '../form/register_form.dart';

class AuthPage extends HookConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2, // Deux onglets : Login et Register
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 60),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 120,
                ),
              ),
              const SizedBox(height: 40),

              // TabBar pour les onglets Login et Register
              const TabBar(
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: "Login"),
                  Tab(text: "Register"),
                ],
              ),
              const SizedBox(height: 30),

              // TabBarView pour le contenu de chaque onglet
              Expanded(
                child: TabBarView(
                  children: [
                    LoginForm(
                      onSwitch: () {
                        DefaultTabController.of(context)?.animateTo(1);
                      },
                    ),
                    RegisterForm(
                      onSwitch: () {
                        DefaultTabController.of(context)?.animateTo(0);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
