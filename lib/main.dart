import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wolkup_app/core/app/app.dart';
import 'package:wolkup_app/core/app/init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();

  runApp(const ProviderScope(child: App()));
}
