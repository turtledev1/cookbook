import 'package:flutter/material.dart';

class AllergensSection extends StatelessWidget {
  const AllergensSection({super.key, required this.allergens});

  final List<String>? allergens;

  @override
  Widget build(BuildContext context) {
    if (allergens == null || allergens!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Allergens',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: allergens!.map((allergen) {
            return Chip(
              label: Text(allergen),
              backgroundColor: Colors.orange.shade100,
              labelStyle: TextStyle(color: Colors.orange.shade900),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
