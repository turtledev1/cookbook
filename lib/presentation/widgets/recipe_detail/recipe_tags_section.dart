import 'package:flutter/material.dart';

class RecipeTagsSection extends StatelessWidget {
  const RecipeTagsSection({super.key, required this.tags});

  final List<String>? tags;

  @override
  Widget build(BuildContext context) {
    if (tags == null || tags!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: tags!.map((tag) {
            return Chip(
              label: Text(tag),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            );
          }).toList(),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}
