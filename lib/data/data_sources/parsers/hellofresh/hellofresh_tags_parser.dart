import 'package:html/dom.dart';

class HelloFreshTagsParser {
  List<String> parse(Document document) {
    final tags = <String>[];

    final tagElements = document.querySelectorAll('[data-test-id="recipe-description-tag"]');

    for (final tagElement in tagElements) {
      final spans = tagElement.querySelectorAll('span');

      if (spans.isNotEmpty) {
        final tag = spans.last.text.trim();

        if (tag.isNotEmpty && !tags.contains(tag)) {
          tags.add(tag);
        }
      }
    }

    return tags;
  }
}
