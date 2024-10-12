import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wolkup_app/core/core.dart';
import 'package:wolkup_app/core/ui/ui.dart';
import 'package:wolkup_app/features/auth/auth.dart';
import 'package:wolkup_app/features/auth/presentation/pages/register_page.dart'; // Import RegisterPage

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final login = useState<Future<void>?>(null);
    final loginSnap = useFuture(login.value);
    final auth = ref.watch(authProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: context.height * 0.24),
            Text('Login', style: context.textTheme.headlineMedium),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loginSnap.isWaiting
                  ? null
                  : () async {
                      login.value = ref.read(authProvider.notifier).login(
                            emailController.text,
                            passwordController.text,
                          );
                    },
              child: BtnChild(
                loading: loginSnap.isWaiting,
                child: const Text('Login'),
              ),
            ),
            const SizedBox(height: 20),
            // Add a button to navigate to the Register page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    // Utilise GoRouter pour naviguer vers la page de Register
                    context.go('/register');
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
