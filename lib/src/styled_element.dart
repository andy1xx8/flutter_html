import 'package:flutter/material.dart';
import 'package:flutter_html/src/html_elements.dart';
import 'package:flutter_html/style.dart';
import 'package:html/dom.dart' as dom;

//TODO(Sub6Resources): don't use the internal code of the html package as it may change unexpectedly.
import 'package:html/src/query_selector.dart';

/// A [StyledElement] applies a style to all of its children.
class StyledElement {
  final String name;
  final String elementId;
  final List<String> elementClasses;
  List<StyledElement> children;
  Style style;
  final dom.Node? _node;

  StyledElement({
    this.name = "[[No name]]",
    this.elementId = "[[No ID]]",
    this.elementClasses = const [],
    required this.children,
    required this.style,
    required dom.Element? node,
  }) : this._node = node;

  bool matchesSelector(String selector) => _node != null && matches(_node as dom.Element, selector);

  Map<String, String> get attributes =>
      _node?.attributes.map((key, value) {
        return MapEntry(key.toString(), value);
      }) ??
      Map<String, String>();

  dom.Element? get element => _node as dom.Element?;

  @override
  String toString() {
    String selfData =
        "[$name] ${children.length} ${elementClasses.isNotEmpty == true ? 'C:${elementClasses.toString()}' : ''}${elementId.isNotEmpty == true ? 'ID: $elementId' : ''}";
    children.forEach((child) {
      selfData += ("\n${child.toString()}").replaceAll(RegExp("^", multiLine: true), "-");
    });
    return selfData;
  }
}

StyledElement parseStyledElement(
  dom.Element element,
  List<StyledElement> children, {
  Style? inlineStyle,
}) {
  StyledElement styledElement = StyledElement(
    name: element.localName!,
    elementId: element.id,
    elementClasses: element.classes.toList(),
    children: children,
    node: element,
    style: inlineStyle?.copyWith() ?? Style(),
  );

  switch (element.localName) {
    case "abbr":
    case "acronym":
      styledElement.style = styledElement.style.copyWith(
        textDecoration: TextDecoration.underline,
        textDecorationStyle: TextDecorationStyle.dotted,
      );
      break;
    case "address":
      continue italics;
    case "article":
      styledElement.style = styledElement.style.copyWith(
        display: containsClazz(element, 'inline') ? Display.INLINE_BLOCK : Display.BLOCK,
      );
      break;
    case "aside":
      styledElement.style = styledElement.style.copyWith(
        display: containsClazz(element, 'inline') ? Display.INLINE_BLOCK : Display.BLOCK,
      );
      break;
    bold:
    case "b":
      styledElement.style = styledElement.style.copyWith(
        fontWeight: FontWeight.bold,
      );
      break;
    case "bdo":
      final TextDirection textDirection =
          ((element.attributes["dir"] ?? "ltr") == "rtl") ? TextDirection.rtl : TextDirection.ltr;

      styledElement.style = styledElement.style.copyWith(
        direction: textDirection,
      );
      break;
    case "big":
      styledElement.style = styledElement.style.copyWith(
        fontSize: FontSize.larger,
      );
      break;
    case "blockquote":
      if ((element.parent?.localName ?? '') == "blockquote") {
        styledElement.style = styledElement.style.copyWith(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          display: containsClazz(element, 'inline') ? Display.INLINE_BLOCK : Display.BLOCK,
        );
      } else {
        styledElement.style = styledElement.style.copyWith(
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          display: containsClazz(element, 'inline') ? Display.INLINE_BLOCK : Display.BLOCK,
        );
      }
      break;
    case "body":
      styledElement.style = styledElement.style.copyWith(
        margin: EdgeInsets.all(5.0),
        display: Display.BLOCK,
      );
      break;
    case "center":
      styledElement.style = styledElement.style.copyWith(
        alignment: Alignment.center,
        display: Display.BLOCK,
      );
      break;
    case "cite":
      continue italics;
    monospace:
    case "code":
      styledElement.style = styledElement.style.copyWith(
        fontFamily: 'Monospace',
      );
      break;
    case "dd":
      styledElement.style = styledElement.style.copyWith(
        margin: EdgeInsets.only(left: 10.0),
        display: Display.BLOCK,
      );
      break;
    strikeThrough:
    case "del":
      styledElement.style = styledElement.style.copyWith(
        textDecoration: TextDecoration.lineThrough,
      );
      break;
    case "dfn":
      continue italics;
    case "div":
      styledElement.style = styledElement.style.copyWith(
        margin: EdgeInsets.all(0),
        display: containsClazz(element, 'bbCodeBlock') ? Display.BLOCK : Display.INLINE_BLOCK,
        //  display: containsClazz(element, 'inline') ? Display.INLINE_BLOCK : Display.BLOCK,
      );
      if (children.isEmpty) return EmptyContentElement(name: '');
      break;
    case "dl":
      styledElement.style = styledElement.style.copyWith(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        display: Display.BLOCK,
      );
      break;
    case "dt":
      styledElement.style = styledElement.style.copyWith(
        display: Display.BLOCK,
      );
      break;
    case "em":
      continue italics;
    case "figcaption":
      styledElement.style = styledElement.style.copyWith(
        display: Display.BLOCK,
      );
      break;
    case "figure":
      styledElement.style = styledElement.style.copyWith(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        display: Display.BLOCK,
      );
      break;
    case "footer":
      styledElement.style = styledElement.style.copyWith(
        display: Display.BLOCK,
      );
      break;
    case "h1":
      styledElement.style = styledElement.style.copyWith(
        fontSize: FontSize.xxLarge,
        fontWeight: FontWeight.bold,
        margin: EdgeInsets.symmetric(vertical: 18.67),
        display: containsClazz(element, 'inline') ? Display.INLINE_BLOCK : Display.BLOCK,
      );
      break;
    case "h2":
      styledElement.style = styledElement.style.copyWith(
        fontSize: FontSize.xLarge,
        fontWeight: FontWeight.bold,
        margin: EdgeInsets.symmetric(vertical: 17.5),
        display: containsClazz(element, 'inline') ? Display.INLINE_BLOCK : Display.BLOCK,
      );
      break;
    case "h3":
      styledElement.style = styledElement.style.copyWith(
        fontSize: FontSize(16.38),
        fontWeight: FontWeight.bold,
        margin: EdgeInsets.symmetric(vertical: 16.5),
        display: containsClazz(element, 'inline') ? Display.INLINE_BLOCK : Display.BLOCK,
      );
      break;
    case "h4":
      styledElement.style = styledElement.style.copyWith(
        fontSize: FontSize.medium,
        fontWeight: FontWeight.bold,
        margin: EdgeInsets.symmetric(vertical: 18.5),
        display: containsClazz(element, 'inline') ? Display.INLINE_BLOCK : Display.BLOCK,
      );
      break;
    case "h5":
      styledElement.style = styledElement.style.copyWith(
        fontSize: FontSize(11.62),
        fontWeight: FontWeight.bold,
        margin: EdgeInsets.symmetric(vertical: 19.25),
        display: containsClazz(element, 'inline') ? Display.INLINE_BLOCK : Display.BLOCK,
      );
      break;
    case "h6":
      styledElement.style = styledElement.style.copyWith(
        fontSize: FontSize(9.38),
        fontWeight: FontWeight.bold,
        margin: EdgeInsets.symmetric(vertical: 22),
        display: containsClazz(element, 'inline') ? Display.INLINE_BLOCK : Display.BLOCK,
      );
      break;
    case "header":
      styledElement.style = styledElement.style.copyWith(
        display: Display.BLOCK,
      );
      break;
    case "hr":
      styledElement.style = styledElement.style.copyWith(
        margin: EdgeInsets.symmetric(vertical: 7.0),
        width: double.infinity,
        border: Border(bottom: BorderSide(width: 1.0)),
        display: Display.BLOCK,
      );
      break;
    case "html":
      styledElement.style = styledElement.style.copyWith(
        display: Display.BLOCK,
      );
      break;
    italics:
    case "i":
      styledElement.style = styledElement.style.copyWith(
        fontStyle: FontStyle.italic,
      );
      break;
    case "ins":
      continue underline;
    case "kbd":
      continue monospace;
    case "li":
      styledElement.style = styledElement.style.copyWith(
        display: Display.LIST_ITEM,
        listStyleType: element.localName == "ol" ? ListStyleType.DECIMAL : ListStyleType.DISC,
      );
      break;
    case "main":
      styledElement.style = styledElement.style.copyWith(
        display: Display.BLOCK,
      );
      break;
    case "mark":
      styledElement.style = styledElement.style.copyWith(
        color: Colors.black,
        backgroundColor: Colors.yellow,
      );
      break;
    case "nav":
      styledElement.style = styledElement.style.copyWith(
        display: Display.BLOCK,
      );
      break;
    case "noscript":
      styledElement.style = styledElement.style.copyWith(
        display: Display.BLOCK,
      );
      break;
    case "ol":
    case "ul":
      //TODO(Sub6Resources): This is a workaround for collapsed margins. Remove.
      if (element.parent?.localName == "li") {
        styledElement.style = styledElement.style.copyWith(
          display: Display.BLOCK,
          listStyleType: element.localName == "ol" ? ListStyleType.DECIMAL : ListStyleType.DISC,
        );
      } else {
        styledElement.style = styledElement.style.copyWith(
          display: Display.BLOCK,
          listStyleType: element.localName == "ol" ? ListStyleType.DECIMAL : ListStyleType.DISC,
        );
      }
      break;
    case "p":
      styledElement.style = styledElement.style.copyWith(
        margin: EdgeInsets.symmetric(vertical: 14.0),
        display: containsClazz(element, 'inline') ? Display.INLINE_BLOCK : Display.BLOCK,
      );
      break;
    case "pre":
      styledElement.style = styledElement.style.copyWith(
        fontFamily: 'monospace',
        margin: EdgeInsets.symmetric(vertical: 14.0),
        whiteSpace: WhiteSpace.PRE,
        display: containsClazz(element, 'inline') ? Display.INLINE_BLOCK : Display.BLOCK,
      );
      break;
    case "q":
      styledElement.style = styledElement.style.copyWith(
        before: "\"",
        after: "\"",
      );
      break;
    case "s":
      continue strikeThrough;
    case "samp":
      continue monospace;
    case "section":
      styledElement.style = styledElement.style.copyWith(
        display: containsClazz(element, 'inline') ? Display.INLINE_BLOCK : Display.BLOCK,
      );
      break;
    case "small":
      styledElement.style = styledElement.style.copyWith(
        fontSize: FontSize.smaller,
      );
      break;
    case "strike":
      continue strikeThrough;
    case "strong":
      continue bold;
    case "sub":
      styledElement.style = styledElement.style.copyWith(
        fontSize: FontSize.smaller,
        verticalAlign: VerticalAlign.SUB,
      );
      break;
    case "sup":
      styledElement.style = styledElement.style.copyWith(
        fontSize: FontSize.smaller,
        verticalAlign: VerticalAlign.SUPER,
      );
      break;
    case "th":
      continue bold;
    case "tt":
      continue monospace;
    underline:
    case "u":
      styledElement.style = styledElement.style.copyWith(
        textDecoration: TextDecoration.underline,
      );
      break;
    case "var":
      continue italics;
  }

  return styledElement;
}

bool containsClazz(dom.Element element, String clazz) {
  if (element.attributes != null) {
    return (element.attributes['class'] ?? "").contains(clazz);
  } else
    return false;
}

typedef ListCharacter = String Function(int i);
