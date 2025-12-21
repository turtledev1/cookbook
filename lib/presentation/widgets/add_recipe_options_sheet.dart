import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cookbook/router_names.dart';

class AddRecipeOptionsSheet extends StatelessWidget {
  const AddRecipeOptionsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.create),
            title: const Text('Create from Scratch'),
            subtitle: const Text('Manually enter recipe details'),
            onTap: () {
              Navigator.pop(context);
              context.pushNamed(RouteNames.createRecipe);
            },
          ),
          ListTile(
            leading: const Icon(Icons.link),
            title: const Text('Import from Website'),
            subtitle: const Text('Parse recipe from a URL'),
            onTap: () {
              Navigator.pop(context);
              context.pushNamed(RouteNames.importRecipe);
            },
          ),
        ],
      ),
    );
  }
}
