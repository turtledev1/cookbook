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
          spacing: 6,
          runSpacing: 4,
          children: allergens!.map((allergen) {
            return Chip(
              label: Text(allergen),
              backgroundColor: Colors.orange.shade100,
              labelStyle: TextStyle(color: Colors.orange.shade900),
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
