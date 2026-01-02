import 'package:html/dom.dart';

class HelloFreshImageParser {
  String? parse(Document document) {
    final imageDiv = document.querySelector('div[data-test-id="recipe-hero-image"]');
    if (imageDiv == null) return null;

    final imgElement = imageDiv.querySelector('img');
    if (imgElement == null) return null;

    final src = imgElement.attributes['src'];
    if (src != null && src.isNotEmpty) {
      return src;
    }

    return null;
  }
}
