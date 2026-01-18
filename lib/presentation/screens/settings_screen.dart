import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cookbook/presentation/blocs/settings_cubit.dart';
import 'package:cookbook/presentation/blocs/recipe_cubit.dart';
import 'package:cookbook/presentation/blocs/recipe_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return ListView(
            children: [
              _buildThemeSection(context, state),
              const Divider(),
              _buildSortOrderSection(context, state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildThemeSection(BuildContext context, SettingsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Theme',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        RadioGroup<ThemeMode>(
          groupValue: state.themeMode,
          onChanged: (value) {
            if (value != null) {
              context.read<SettingsCubit>().setThemeMode(value);
            }
          },
          child: const Column(
            children: [
              RadioListTile<ThemeMode>(
                title: Text('Light'),
                subtitle: Text('Always use light theme'),
                value: ThemeMode.light,
              ),
              RadioListTile<ThemeMode>(
                title: Text('Dark'),
                subtitle: Text('Always use dark theme'),
                value: ThemeMode.dark,
              ),
              RadioListTile<ThemeMode>(
                title: Text('System'),
                subtitle: Text('Follow system theme settings'),
                value: ThemeMode.system,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSortOrderSection(BuildContext context, SettingsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Default Sort Order',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        BlocBuilder<RecipeCubit, RecipeState>(
          builder: (context, _) {
            return RadioGroup<SortOrder>(
              groupValue: state.sortOrder,
              onChanged: (value) {
                if (value != null) {
                  context.read<SettingsCubit>().setSortOrder(value);
                  context.read<RecipeCubit>().applySortOrder();
                }
              },
              child: const Column(
                children: [
                  RadioListTile<SortOrder>(
                    title: Text('Alphabetical'),
                    subtitle: Text('Sort recipes A-Z'),
                    value: SortOrder.alphabetical,
                  ),
                  RadioListTile<SortOrder>(
                    title: Text('Newest First'),
                    subtitle: Text('Most recently added recipes first'),
                    value: SortOrder.newest,
                  ),
                  RadioListTile<SortOrder>(
                    title: Text('Oldest First'),
                    subtitle: Text('Oldest recipes first'),
                    value: SortOrder.oldest,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
