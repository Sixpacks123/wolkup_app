import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wolkup_app/core/core.dart';
import 'package:wolkup_app/core/ui/ui.dart';
import 'package:wolkup_app/features/auth/auth.dart';

class RegisterPage extends HookConsumerWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final displayNameController = useTextEditingController(text: '');
    final register = useState<Future<void>?>(null);
    final registerSnap = useFuture(register.value);
    final auth = ref.watch(authProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: context.height * 0.24),
            Text('Register', style: context.textTheme.headlineMedium),
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
            TextField(
              controller: displayNameController,
              decoration: const InputDecoration(
                labelText: 'Display Name',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: registerSnap.isWaiting
                  ? null
                  : () async {
                      final result =
                          await ref.read(authProvider.notifier).register(
                                emailController.text,
                                passwordController.text,
                                displayNameController.text,
                              );

                      if (result == null) {
                        // Registration successful, navigate to home
                        context.go('/');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Registration Successful')),
                        );
                      } else {
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text(result)), // Show error from authProvider
                        );
                      }
                    },
              child: BtnChild(
                loading: registerSnap.isWaiting,
                child: const Text('Register'),
              ),
            ),
            const SizedBox(height: 20),
            // Add a button to navigate to the Login page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Déjà un compte ?"),
                TextButton(
                  onPressed: () {
                    // Navigate back to the login page
                    context.go('/login');
                  },
                  child: const Text('Se connecter'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
