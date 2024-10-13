import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modular_ui/modular_ui.dart';
import 'package:wolkup_app/features/auth/auth.dart';
import 'auth_tabs.dart'; // Ensure AuthTabs is imported
import 'package:wolkup_app/core/core.dart'; // Import the core package

class RegisterPage extends HookConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final displayNameController = useTextEditingController(text: '');
    final register = useState<Future<void>?>(null);
    final registerSnap = useFuture(register.value);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 50),

            // AuthTabs widget to switch between Login and Register
            const AuthTabs(initialIndex: 1), // 1 for Register

            const SizedBox(height: 20),

            // Modular UI Input Fields
            MUIPrimaryInputField(
              controller: emailController,
              hintText: 'Enter your email',
              filledColor: Colors.white,
              borderRadius: 8.0,
              borderWidth: 1.5,
              enabledBorderColor: Colors.black,
              prefixIcon: const Icon(Icons.email, color: Colors.black),
            ),
            const SizedBox(height: 16),
            MUIPrimaryInputField(
              controller: passwordController,
              hintText: 'Enter your password',
              isObscure: true,
              filledColor: Colors.white,
              borderRadius: 8.0,
              borderWidth: 1.5,
              enabledBorderColor: Colors.black,
              prefixIcon: const Icon(Icons.lock, color: Colors.black),
            ),
            const SizedBox(height: 16),
            MUIPrimaryInputField(
              controller: displayNameController,
              hintText: 'Enter your display name',
              filledColor: Colors.white,
              borderRadius: 8.0,
              borderWidth: 1.5,
              enabledBorderColor: Colors.black,
              prefixIcon: const Icon(Icons.person, color: Colors.black),
            ),

            const SizedBox(height: 20),

            // Modular UI Primary Button
            Center(
              child: SizedBox(
                width: double.infinity,
                child: MUIPrimaryButton(
                  text: 'Register',
                  onPressed: () {
                    if (!registerSnap.isWaiting) {
                      register.value = ref.read(authProvider.notifier).register(
                            emailController.text,
                            passwordController.text,
                            displayNameController.text,
                          );
                    }
                  },
                  bgColor: Colors.black,
                  textColor: Colors.white,
                  borderRadius: 8.0,
                  hapticsEnabled: true,
                  leadingIcon: registerSnap.isWaiting ? null : Icons.person_add,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Login navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    context.go('/login');
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
      ),
    );
  }
}
