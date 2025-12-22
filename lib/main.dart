import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cookbook/app_config.dart';
import 'package:cookbook/injection.dart';
import 'package:cookbook/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Determine environment based on build mode
  // Debug mode: use dev Firebase (dev_shared_recipes)
  // Release mode: use prod Firebase (shared_recipes)
  const buildEnv = kReleaseMode ? BuildEnvironment.prod : BuildEnvironment.dev;

  AppConfig.initialize(environment: buildEnv);

  // Initialize Firebase
  await Firebase.initializeApp();

  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Personal Cookbook ${AppConfig.isDev ? '(DEV)' : ''}',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange)),
      routerConfig: goRouter,
    );
  }
}
