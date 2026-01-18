import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:cookbook/domain/models/recipe.dart';
import 'package:cookbook/presentation/blocs/recipe_cubit.dart';

class RecipeFormScreen extends StatefulWidget {
  const RecipeFormScreen({super.key, this.initialRecipe});

  final Recipe? initialRecipe;

  @override
  State<RecipeFormScreen> createState() => _RecipeFormScreenState();
}

class _RecipeFormScreenState extends State<RecipeFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Basic info controllers
  late TextEditingController _nameController;
  late TextEditingController _prepTimeController;
  late TextEditingController _cookTimeController;
  late TextEditingController _imageUrlController;

  // Nutrition controllers
  late TextEditingController _caloriesController;
  late TextEditingController _proteinController;
  late TextEditingController _carbsController;
  late TextEditingController _fatController;
  late TextEditingController _fiberController;
  late TextEditingController _sodiumController;

  // List controllers
  List<TextEditingController> _ingredientControllers = [];
  List<TextEditingController> _stepControllers = [];

  // Other fields
  RecipeDifficulty? _difficulty;
  List<String> _tags = [];
  List<String> _allergens = [];

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    final recipe = widget.initialRecipe;

    // Initialize basic info controllers
    _nameController = TextEditingController(text: recipe?.name ?? '');
    _prepTimeController = TextEditingController(text: recipe?.prepTimeMinutes.toString() ?? '');
    _cookTimeController = TextEditingController(text: recipe?.cookTimeMinutes.toString() ?? '');
    _imageUrlController = TextEditingController(text: recipe?.imageUrl ?? '');

    // Initialize nutrition controllers
    _caloriesController = TextEditingController(text: recipe?.nutritionalInfo.calories.toString() ?? '');
    _proteinController = TextEditingController(text: recipe?.nutritionalInfo.protein?.toString() ?? '');
    _carbsController = TextEditingController(text: recipe?.nutritionalInfo.carbs?.toString() ?? '');
    _fatController = TextEditingController(text: recipe?.nutritionalInfo.fat?.toString() ?? '');
    _fiberController = TextEditingController(text: recipe?.nutritionalInfo.fiber?.toString() ?? '');
    _sodiumController = TextEditingController(text: recipe?.nutritionalInfo.sodium?.toString() ?? '');

    // Initialize other fields
    _difficulty = recipe?.difficulty;
    _tags = List<String>.from(recipe?.tags ?? []);
    _allergens = List<String>.from(recipe?.allergens ?? []);

    // Initialize ingredient controllers
    if (recipe != null && recipe.ingredients.isNotEmpty) {
      _ingredientControllers = recipe.ingredients
          .map((ingredient) => TextEditingController(text: ingredient))
          .toList();
    } else {
      _ingredientControllers = [TextEditingController()];
    }

    // Initialize step controllers
    if (recipe != null && recipe.steps.isNotEmpty) {
      _stepControllers = recipe.steps
          .map((step) => TextEditingController(text: step))
          .toList();
    } else {
      _stepControllers = [TextEditingController()];
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _prepTimeController.dispose();
    _cookTimeController.dispose();
    _imageUrlController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    _fiberController.dispose();
    _sodiumController.dispose();

    for (final controller in _ingredientControllers) {
      controller.dispose();
    }
    for (final controller in _stepControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            // Image header
            _buildImageHeader(),

            // Form content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Image URL input
                    _buildImageUrlInput(),
                    const SizedBox(height: 24),

                    // Basic Info Section
                    _buildBasicInfoSection(),
                    const SizedBox(height: 16),

                    // Ingredients Section
                    _buildIngredientsSection(),
                    const SizedBox(height: 16),

                    // Steps Section
                    _buildStepsSection(),
                    const SizedBox(height: 16),

                    // Tags Section
                    _buildTagsSection(),
                    const SizedBox(height: 16),

                    // Allergens Section
                    _buildAllergensSection(),
                    const SizedBox(height: 16),

                    // Nutrition Section
                    _buildNutritionSection(),
                    const SizedBox(height: 24),

                    // Save Button
                    _buildSaveButton(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageHeader() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: _imageUrlController.text.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: _imageUrlController.text,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.add_photo_alternate, size: 64, color: Colors.grey),
                  ),
                ),
              )
            : Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.add_photo_alternate, size: 64, color: Colors.grey),
                ),
              ),
      ),
    );
  }

  Widget _buildImageUrlInput() {
    return TextFormField(
      controller: _imageUrlController,
      decoration: const InputDecoration(
        labelText: 'Image URL (optional)',
        helperText: 'Enter a URL for the recipe image',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) => setState(() {}), // Refresh image header
    );
  }

  Widget _buildBasicInfoSection() {
    return ExpansionTile(
      title: const Text('Basic Information'),
      initiallyExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Recipe Name *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a recipe name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Prep and Cook Time
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _prepTimeController,
                      decoration: const InputDecoration(
                        labelText: 'Prep Time (min) *',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        final time = int.tryParse(value);
                        if (time == null || time < 0) {
                          return 'Invalid';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _cookTimeController,
                      decoration: const InputDecoration(
                        labelText: 'Cook Time (min) *',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        final time = int.tryParse(value);
                        if (time == null || time < 0) {
                          return 'Invalid';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Difficulty
              DropdownButtonFormField<RecipeDifficulty>(
                value: _difficulty,
                decoration: const InputDecoration(
                  labelText: 'Difficulty (optional)',
                  border: OutlineInputBorder(),
                ),
                items: RecipeDifficulty.values.map((difficulty) {
                  return DropdownMenuItem(
                    value: difficulty,
                    child: Text(_getDifficultyLabel(difficulty)),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _difficulty = value),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIngredientsSection() {
    return ExpansionTile(
      title: const Text('Ingredients'),
      initiallyExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ..._ingredientControllers.asMap().entries.map((entry) {
                final index = entry.key;
                final controller = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          decoration: InputDecoration(
                            labelText: 'Ingredient ${index + 1}',
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (_ingredientControllers.length == 1 && (value == null || value.trim().isEmpty)) {
                              return 'At least one ingredient required';
                            }
                            return null;
                          },
                        ),
                      ),
                      if (_ingredientControllers.length > 1)
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => _removeIngredient(index),
                        ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add Ingredient'),
                onPressed: _addIngredient,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepsSection() {
    return ExpansionTile(
      title: const Text('Instructions'),
      initiallyExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ..._stepControllers.asMap().entries.map((entry) {
                final index = entry.key;
                final controller = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, right: 8),
                        child: Text(
                          '${index + 1}.',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          decoration: InputDecoration(
                            labelText: 'Step ${index + 1}',
                            border: const OutlineInputBorder(),
                          ),
                          maxLines: 3,
                          validator: (value) {
                            if (_stepControllers.length == 1 && (value == null || value.trim().isEmpty)) {
                              return 'At least one step required';
                            }
                            return null;
                          },
                        ),
                      ),
                      if (_stepControllers.length > 1)
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => _removeStep(index),
                        ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add Step'),
                onPressed: _addStep,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTagsSection() {
    return ExpansionTile(
      title: const Text('Tags'),
      initiallyExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ..._tags.map((tag) => Chip(
                label: Text(tag),
                onDeleted: () => _removeTag(tag),
              )),
              ActionChip(
                avatar: const Icon(Icons.add, color: Colors.black87),
                label: const Text('Add Tag', style: TextStyle(color: Colors.black87)),
                backgroundColor: const Color.fromRGBO(179, 232, 180, 1),
                onPressed: _showAddTagDialog,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAllergensSection() {
    return ExpansionTile(
      title: const Text('Allergens'),
      initiallyExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ..._allergens.map((allergen) => Chip(
                label: Text(allergen),
                backgroundColor: Colors.orange.shade100,
                labelStyle: TextStyle(color: Colors.orange.shade900),
                onDeleted: () => _removeAllergen(allergen),
              )),
              ActionChip(
                avatar: Icon(Icons.add, color: Colors.orange.shade900),
                label: Text('Add Allergen', style: TextStyle(color: Colors.orange.shade900)),
                backgroundColor: Colors.orange.shade100,
                onPressed: _showAddAllergenDialog,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionSection() {
    return ExpansionTile(
      title: const Text('Nutritional Information'),
      initiallyExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Calories (required)
              TextFormField(
                controller: _caloriesController,
                decoration: const InputDecoration(
                  labelText: 'Calories *',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Calories required';
                  }
                  final calories = int.tryParse(value);
                  if (calories == null || calories <= 0) {
                    return 'Invalid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Optional nutrition fields in a grid
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _proteinController,
                      decoration: const InputDecoration(
                        labelText: 'Protein (g)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _carbsController,
                      decoration: const InputDecoration(
                        labelText: 'Carbs (g)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _fatController,
                      decoration: const InputDecoration(
                        labelText: 'Fat (g)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _fiberController,
                      decoration: const InputDecoration(
                        labelText: 'Fiber (g)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _sodiumController,
                decoration: const InputDecoration(
                  labelText: 'Sodium (mg)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return FilledButton(
      onPressed: _isSaving ? null : _saveRecipe,
      child: _isSaving
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(widget.initialRecipe == null ? 'Create Recipe' : 'Update Recipe'),
    );
  }

  void _addIngredient() {
    setState(() {
      _ingredientControllers.add(TextEditingController());
    });
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredientControllers[index].dispose();
      _ingredientControllers.removeAt(index);
    });
  }

  void _addStep() {
    setState(() {
      _stepControllers.add(TextEditingController());
    });
  }

  void _removeStep(int index) {
    setState(() {
      _stepControllers[index].dispose();
      _stepControllers.removeAt(index);
    });
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  void _removeAllergen(String allergen) {
    setState(() {
      _allergens.remove(allergen);
    });
  }

  Future<void> _showAddTagDialog() async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Tag'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Tag name',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text.trim()),
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        _tags.add(result);
      });
    }
    controller.dispose();
  }

  Future<void> _showAddAllergenDialog() async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Allergen'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Allergen name',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text.trim()),
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        _allergens.add(result);
      });
    }
    controller.dispose();
  }

  Future<void> _saveRecipe() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSaving = true);

    try {
      // Build recipe from form data
      final recipe = _buildRecipeFromForm();

      // Save via cubit
      final cubit = context.read<RecipeCubit>();
      if (widget.initialRecipe == null) {
        await cubit.addRecipe(recipe);
      } else {
        await cubit.updateRecipe(recipe);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.initialRecipe == null
                ? 'Recipe created successfully!'
                : 'Recipe updated successfully!'),
          ),
        );

        // When editing, pop twice to go back to home (form -> detail -> home)
        // When creating, pop once to go back to home (form -> home)
        if (widget.initialRecipe != null) {
          // Pop from form to detail screen
          context.pop();
          // Pop from detail screen to home
          if (mounted) {
            context.pop();
          }
        } else {
          context.pop();
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save recipe: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Recipe _buildRecipeFromForm() {
    // Get non-empty ingredients and steps
    final ingredients = _ingredientControllers
        .map((controller) => controller.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    final steps = _stepControllers
        .map((controller) => controller.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    // Parse nutrition values
    final nutritionalInfo = NutritionalInfo(
      calories: int.parse(_caloriesController.text),
      protein: _proteinController.text.isNotEmpty ? int.tryParse(_proteinController.text) : null,
      carbs: _carbsController.text.isNotEmpty ? int.tryParse(_carbsController.text) : null,
      fat: _fatController.text.isNotEmpty ? int.tryParse(_fatController.text) : null,
      fiber: _fiberController.text.isNotEmpty ? int.tryParse(_fiberController.text) : null,
      sodium: _sodiumController.text.isNotEmpty ? int.tryParse(_sodiumController.text) : null,
    );

    final now = DateTime.now();

    // If editing, use existing ID and created date
    if (widget.initialRecipe != null) {
      return widget.initialRecipe!.copyWith(
        name: _nameController.text.trim(),
        ingredients: ingredients,
        steps: steps,
        prepTimeMinutes: int.parse(_prepTimeController.text),
        cookTimeMinutes: int.parse(_cookTimeController.text),
        difficulty: _difficulty,
        tags: _tags.isEmpty ? null : _tags,
        allergens: _allergens.isEmpty ? null : _allergens,
        nutritionalInfo: nutritionalInfo,
        imageUrl: _imageUrlController.text.trim().isEmpty ? null : _imageUrlController.text.trim(),
        updatedAt: now,
      );
    } else {
      // Creating new recipe
      return Recipe(
        id: const Uuid().v4(),
        name: _nameController.text.trim(),
        ingredients: ingredients,
        steps: steps,
        prepTimeMinutes: int.parse(_prepTimeController.text),
        cookTimeMinutes: int.parse(_cookTimeController.text),
        difficulty: _difficulty,
        tags: _tags.isEmpty ? null : _tags,
        allergens: _allergens.isEmpty ? null : _allergens,
        nutritionalInfo: nutritionalInfo,
        imageUrl: _imageUrlController.text.trim().isEmpty ? null : _imageUrlController.text.trim(),
        createdAt: now,
        updatedAt: now,
      );
    }
  }

  String _getDifficultyLabel(RecipeDifficulty difficulty) {
    switch (difficulty) {
      case RecipeDifficulty.easy:
        return 'Easy';
      case RecipeDifficulty.medium:
        return 'Medium';
      case RecipeDifficulty.hard:
        return 'Hard';
    }
  }
}
