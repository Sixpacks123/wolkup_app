import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart'; // Import GoRouter

import '../states/auth.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscurePassword = useState(true);

    return Scaffold(
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
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
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
                  onPressed: () {
                    context.go('/auth/register'); // Use GoRouter to navigate
                  },
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
            const Text('Or', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey[300],
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {
                  // Logic for Google login
                },
                child: const Wrap(
                  children: [
                    Icon(Icons.g_mobiledata),
                    SizedBox(width: 10),
                    Text('Login with Google'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey[300],
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {
                  // Logic for Apple login
                },
                child: const Wrap(
                  children: [
                    Icon(Icons.apple),
                    SizedBox(width: 10),
                    Text('Login with Apple'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
