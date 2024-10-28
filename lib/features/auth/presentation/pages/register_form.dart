import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modular_ui/modular_ui.dart';
import 'package:wolkup_app/core/core.dart';
import 'package:wolkup_app/features/auth/auth.dart';

class RegisterForm extends HookConsumerWidget {
  final VoidCallback onSwitch;

  const RegisterForm({required this.onSwitch, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final displayNameController = useTextEditingController();
    final registerSnap = useFuture(useState<Future<void>?>(null).value);

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
        const SizedBox(height: 16),
        MUIPrimaryInputField(
          controller: displayNameController,
          hintText: 'Enter your display name',
          prefixIcon: const Icon(Icons.person, color: Colors.black), filledColor: Colors.white,
        ),
        const SizedBox(height: 20),
        Center(
          child: SizedBox(
            width: double.infinity, // Prend toute la largeur disponible
            child: MUIPrimaryButton(
              text: 'Register',
              onPressed: () {
                if (!registerSnap.isWaiting) {
                  ref.read(authProvider.notifier).register(
                    emailController.text,
                    passwordController.text,
                    displayNameController.text,
                  );
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 20),


        // Texte pour rediriger vers Login
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account?"),
            TextButton(
              onPressed: onSwitch,
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
    );
  }
}
