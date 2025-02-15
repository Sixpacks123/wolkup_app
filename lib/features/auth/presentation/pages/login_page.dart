import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../states/auth.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscurePassword = useState(true);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calculer la hauteur du header (1/3 de la page)
          final containerHeight = constraints.maxHeight / 3;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Header
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
                        width: 300,
                      ),
                    ),
                  ),
                ),

                // Texte Bienvenue
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Bienvenue',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary, // Couleur primaire du thème
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Formulaire de connexion
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
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: obscurePassword.value,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(obscurePassword.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          obscurePassword.value = !obscurePassword.value;
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Bouton Login
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        ref.read(authProvider.notifier).login(
                          emailController.text,
                          passwordController.text,
                        );
                      },
                      child: const Text('se connecter'),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Bouton Register
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {
                        context.go('/auth/register');
                      },
                      child: const Text('s''inscrire'),
                    ),
                  ),
                ),

                const SizedBox(height: 20),



              ],
            ),
          );
        },
      ),
    );
  }
}
