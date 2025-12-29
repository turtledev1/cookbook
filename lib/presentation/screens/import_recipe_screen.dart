import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cookbook/data/data_sources/parsers/hellofresh/hellofresh_parser.dart';
import 'package:cookbook/domain/models/recipe.dart';
import 'package:cookbook/presentation/blocs/recipe_cubit.dart';
import 'package:cookbook/presentation/widgets/recipe_preview_card.dart';

class ImportRecipeScreen extends StatefulWidget {
  const ImportRecipeScreen({super.key});

  @override
  State<ImportRecipeScreen> createState() => _ImportRecipeScreenState();
}

class _ImportRecipeScreenState extends State<ImportRecipeScreen> {
  final _urlController = TextEditingController();
  final _parser = HelloFreshParser();
  Recipe? _parsedRecipe;
  bool _isLoading = false;
  bool _isSaving = false;
  String? _error;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _parseUrl() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      setState(() {
        _error = 'Please enter a URL';
      });
      return;
    }

    if (!url.contains('hellofresh.ca/recipes/')) {
      setState(() {
        _error = 'Only HelloFresh CA recipes are supported';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
      _parsedRecipe = null;
    });

    try {
      final recipe = await _parser.parseRecipeFromUrl(url);
      setState(() {
        _parsedRecipe = recipe;
        _isLoading = false;
        if (recipe == null) {
          _error = 'Failed to parse recipe';
        }
      });
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _saveRecipe() async {
    if (_parsedRecipe == null) return;

    setState(() {
      _isSaving = true;
      _error = null;
    });

    try {
      await context.read<RecipeCubit>().addRecipe(_parsedRecipe!);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Recipe saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to save recipe: $e';
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import Recipe'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: 'HelloFresh Recipe URL',
                hintText: 'https://www.hellofresh.ca/recipes/...',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _parseUrl,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Parse Recipe'),
            ),
            if (_error != null) ...[
              const SizedBox(height: 16),
              Card(
                color: Colors.red.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    _error!,
                    style: TextStyle(color: Colors.red.shade900),
                  ),
                ),
              ),
            ],
            if (_parsedRecipe != null) ...[
              const SizedBox(height: 24),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Parsed Recipe:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _isSaving ? null : _saveRecipe,
                    icon: _isSaving
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save),
                    label: const Text('Save Recipe'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              RecipePreviewCard(recipe: _parsedRecipe!),
            ],
          ],
        ),
      ),
    );
  }
}
