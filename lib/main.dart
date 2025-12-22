import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cookbook/app_config.dart';
import 'package:cookbook/injection.dart';
import 'package:cookbook/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Determine environment based on build mode
  // In debug mode: use dev Firebase project
  // In release mode: use prod Firebase project
  // Can also be overridden with --dart-define arguments
  const environment = String.fromEnvironment('ENV', defaultValue: '');
  final BuildEnvironment buildEnv;

  if (environment.isNotEmpty) {
    // Allow override via: flutter run --dart-define=ENV=local
    buildEnv = BuildEnvironment.values.firstWhere(
      (e) => e.name == environment,
      orElse: () => kReleaseMode ? BuildEnvironment.prod : BuildEnvironment.dev,
    );
  } else {
    // Default: dev in debug mode, prod in release mode
    buildEnv = kReleaseMode ? BuildEnvironment.prod : BuildEnvironment.dev;
  }

  AppConfig.initialize(environment: buildEnv);

  // Only initialize Firebase if using Firestore
  if (AppConfig.useFirestore) {
    await Firebase.initializeApp();
  }

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
