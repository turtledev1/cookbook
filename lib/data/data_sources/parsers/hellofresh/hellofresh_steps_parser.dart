import 'package:html/dom.dart';

class HelloFreshStepsParser {
  List<String> parse(Document document) {
    final steps = <String>[];
    
    final stepElements = document.querySelectorAll('[data-test-id="instruction-step"]');
    
    for (final stepElement in stepElements) {
      final stepText = stepElement.text.trim();
      
      if (stepText.isNotEmpty && stepText.length > 10) {
        var cleaned = stepText
            .replaceAll(RegExp(r'^\d+\s*'), '')
            .replaceAll('•', '')
            .replaceAll(RegExp(r'\s+'), ' ')
            .trim();
        
        if (cleaned.isNotEmpty && !steps.contains(cleaned)) {
          steps.add(cleaned);
        }
      }
    }

    return steps;
  }
}
