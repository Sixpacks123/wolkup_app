import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wolkup_app/core/ui/ui.dart';
import 'package:wolkup_app/features/auth/auth.dart';
import 'package:modular_ui/modular_ui.dart'; // Modular UI for inputs/buttons
import 'auth_tabs.dart'; // Import the new AuthTabs widget
import 'package:wolkup_app/core/core.dart'; // Import the core package

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final login = useState<Future<void>?>(null);
    final loginSnap = useFuture(login.value);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 50), // Space for the tabs

            // Add the AuthTabs here
            const AuthTabs(initialIndex: 0), // 0 for Login

            const SizedBox(height: 20),

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
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: MUIPrimaryButton(
                  text: 'Login',
                  onPressed: () {
                    if (!loginSnap.isWaiting) {
                      login.value = ref.read(authProvider.notifier).login(
                            emailController.text,
                            passwordController.text,
                          );
                    }
                  },
                  bgColor: Colors.black,
                  textColor: Colors.white,
                  borderRadius: 8.0,
                  hapticsEnabled: true,
                  leadingIcon: loginSnap.isWaiting ? null : Icons.login,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
