import 'package:flutter/material.dart';

class IngredientsSection extends StatefulWidget {
  const IngredientsSection({super.key, required this.ingredients});

  final List<String> ingredients;

  @override
  State<IngredientsSection> createState() => _IngredientsSectionState();
}

class _IngredientsSectionState extends State<IngredientsSection> {
  late List<bool> _checkedItems;

  @override
  void initState() {
    super.initState();
    _checkedItems = List.filled(widget.ingredients.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ingredients',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...widget.ingredients.asMap().entries.map((entry) {
          final index = entry.key;
          final ingredient = entry.value;
          return InkWell(
            onTap: () {
              setState(() {
                _checkedItems[index] = !_checkedItems[index];
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _checkedItems[index],
                    onChanged: (value) {
                      setState(() {
                        _checkedItems[index] = value ?? false;
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        ingredient,
                        style: TextStyle(
                          decoration: _checkedItems[index]
                              ? TextDecoration.lineThrough
                              : null,
                          color: _checkedItems[index] ? Colors.grey : null,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 24),
      ],
    );
  }
}
