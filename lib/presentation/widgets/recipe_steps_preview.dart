import 'package:flutter/material.dart';

class RecipeStepsPreview extends StatelessWidget {
  const RecipeStepsPreview({
    super.key,
    required this.steps,
    this.maxVisible = 2,
  });

  final List<String> steps;
  final int maxVisible;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Steps (${steps.length})',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...steps
            .take(maxVisible)
            .map(
              (step) => Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${steps.indexOf(step) + 1}. '),
                    Expanded(child: Text(step)),
                  ],
                ),
              ),
            ),
        if (steps.length > maxVisible)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              '... ${steps.length - maxVisible} more steps',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
            ),
          ),
      ],
    );
  }
}
