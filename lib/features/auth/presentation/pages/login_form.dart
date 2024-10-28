import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modular_ui/modular_ui.dart';
import 'package:wolkup_app/core/core.dart';
import 'package:wolkup_app/features/auth/auth.dart';

class LoginForm extends HookConsumerWidget {
  final VoidCallback onSwitch;

  const LoginForm({required this.onSwitch, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final loginSnap = useFuture(useState<Future<void>?>(null).value);

    return Column(
      children: [
        MUIPrimaryInputField(
          controller: emailController,
          hintText: 'Enter your email',
          prefixIcon: const Icon(Icons.email, color: Colors.black), filledColor: Colors.white,
        ),
        const SizedBox(height: 16),
        MUIPrimaryInputField(
          controller: passwordController,
          hintText: 'Enter your password',
          isObscure: true,
          prefixIcon: const Icon(Icons.lock, color: Colors.black), filledColor: Colors.white,
        ),
        const SizedBox(height: 20),
        Center(
          child: SizedBox(
            width: double.infinity, // Prend toute la largeur disponible
            child: MUIPrimaryButton(
              text: 'Login',
              onPressed: () {
                if (!loginSnap.isWaiting) {
                  ref.read(authProvider.notifier).login(
                    emailController.text,
                    passwordController.text,
                  );
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 20),


        // Texte pour rediriger vers Register
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don’t have an account?"),
            TextButton(
              onPressed: onSwitch,
              child: const Text(
                'Register',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
