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
          spacing: 8,
          runSpacing: 8,
          children: tags!.map((tag) {
            return Chip(
              label: Text(tag),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
