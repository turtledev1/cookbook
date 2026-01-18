import 'package:flutter/material.dart';

class StepsSection extends StatefulWidget {
  const StepsSection({super.key, required this.steps});

  final List<String> steps;

  @override
  State<StepsSection> createState() => _StepsSectionState();
}

class _StepsSectionState extends State<StepsSection> {
  late List<bool> _checkedItems;

  @override
  void initState() {
    super.initState();
    _checkedItems = List.filled(widget.steps.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Instructions',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...widget.steps.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;
          return InkWell(
            onTap: () {
              setState(() {
                _checkedItems[index] = !_checkedItems[index];
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
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
                        '${index + 1}. $step',
                        style: TextStyle(
                          height: 1.5,
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
