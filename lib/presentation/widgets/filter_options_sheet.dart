import 'package:flutter/material.dart';
import '../../domain/models/search_filter.dart';

class FilterOptionsSheet extends StatelessWidget {
  final SearchFilter currentFilter;
  final Function(SearchFilter) onFilterSelected;

  const FilterOptionsSheet({super.key, required this.currentFilter, required this.onFilterSelected});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Search Filter', style: Theme.of(context).textTheme.titleLarge),
          ),
          RadioGroup<SearchFilter>(
            groupValue: currentFilter,
            onChanged: (value) {
              if (value != null) {
                onFilterSelected(value);
                Navigator.pop(context);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: SearchFilter.values.map((filter) {
                return RadioListTile<SearchFilter>(title: Text(filter.label), value: filter);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
