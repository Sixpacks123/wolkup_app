import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart'; // Import GoRouter

import '../states/auth.dart';

class RegisterPage extends HookConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final displayNameController = useTextEditingController();

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
      final containerHeight = constraints.maxHeight / 3;
      return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: containerHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.shadow,

                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(49),
                  bottomRight: Radius.circular(49),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    'assets/images/img.png',
                    height: 120,
                    width: 280,
                  ),
                ),
              ),
            ),
            // Texte Bienvenue
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'inscription',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary, // Couleur primaire du thème
                ),
                textAlign: TextAlign.center,
              ),
            ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
        ),
            Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Enter your password',
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
          ),

            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: TextField(
              controller: displayNameController,
              decoration: const InputDecoration(
                hintText: 'Enter your display name',
                labelText: 'Display Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child : SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ref.read(authProvider.notifier).register(
                    emailController.text,
                    passwordController.text,
                    displayNameController.text,
                  );
                },
                child: const Text('Register'),
              ),
            ),
          ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    context.go('/auth/login'); // Use GoRouter to navigate
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
    ),
    );
  }
}
