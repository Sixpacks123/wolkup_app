import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../states/auth.dart';

class LoginForm extends HookConsumerWidget {
  final VoidCallback onSwitch;

  const LoginForm({required this.onSwitch, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            hintText: 'Enter your email',
            labelText: 'Email',
            prefixIcon: Icon(Icons.email, color: Colors.black),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(
            hintText: 'Enter your password',
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock, color: Colors.black),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              ref.read(authProvider.notifier).login(
                emailController.text,
                passwordController.text,
              );
            },
            child: const Text('Login'),
          ),
        ),
        const SizedBox(height: 20),
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
