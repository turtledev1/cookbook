import 'package:html/dom.dart';

class HelloFreshTagsParser {
  List<String> parse(Document document) {
    final tags = <String>[];
    final bodyText = document.body?.text ?? '';
    
    final tagsMatch = RegExp(r'Tags:([^A-Z]+)', caseSensitive: false).firstMatch(bodyText);
    if (tagsMatch != null) {
      final tagsText = tagsMatch.group(1)!;
      final items = tagsText.split(RegExp(r'[,•]'));
      for (final item in items) {
        final cleaned = item.trim();
        if (cleaned.isNotEmpty && cleaned.length < 30) {
          tags.add(cleaned);
        }
      }
    }

    return tags;
  }
}
