import 'package:html/dom.dart';

class HelloFreshNameParser {
  String parse(Document document) {
    final nameElement = document.querySelector('h1');
    return nameElement?.text.trim() ?? 'Unknown Recipe';
  }
}
