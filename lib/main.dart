import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cookbook/app_config.dart';
import 'package:cookbook/injection.dart';
import 'package:cookbook/presentation/blocs/recipe_cubit.dart';
import 'package:cookbook/presentation/blocs/settings_cubit.dart';
import 'package:cookbook/presentation/themes/app_theme.dart';
import 'package:cookbook/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize HydratedBloc storage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );

  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<RecipeCubit>()..loadRecipes(),
        ),
        BlocProvider(
          create: (context) => getIt<SettingsCubit>(),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settingsState) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Personal Cookbook ${AppConfig.isDev ? '(DEV)' : ''}',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settingsState.themeMode,
            routerConfig: goRouter,
          );
        },
      ),
    );
  }
}
