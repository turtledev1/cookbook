import 'package:html/dom.dart';

class HelloFreshTimeParser {
  int parsePreparationTime(Document document) {
    return _extractTimeByTranslationId(document, 'recipe-detail.preparation-time');
  }

  int parseCookingTime(Document document) {
    return _extractTimeByTranslationId(document, 'recipe-detail.cooking-time');
  }

  int _extractTimeByTranslationId(Document document, String translationId) {
    final element = document.querySelector('[data-translation-id="$translationId"]');
    if (element != null) {
      final parentSpan = element.parent;
      if (parentSpan != null) {
        final nextSibling = parentSpan.nextElementSibling;
        if (nextSibling != null && nextSibling.localName == 'span') {
          final timeText = nextSibling.text.trim();
          return _parseMinutes(timeText);
        }
      }
    }
    return 0;
  }

  int _parseMinutes(String timeText) {
    final match = RegExp(r'(\d+)').firstMatch(timeText);
    if (match != null) {
      return int.tryParse(match.group(1)!) ?? 0;
    }
    return 0;
  }
}
