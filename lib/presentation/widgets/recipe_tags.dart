import 'package:flutter/material.dart';

class RecipeTags extends StatelessWidget {
  final List<String> tags;

  const RecipeTags({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 8,
      children: tags
          .map((tag) => Chip(label: Text(tag), labelStyle: const TextStyle(fontSize: 12)))
          .toList(),
    );
  }
}
