import 'package:flutter/cupertino.dart';
import 'package:flutter_html/css_style/utils.dart';
import 'package:flutter_html/style.dart';

class InlineCssParser {
  static Style parseCss(String style) {
    var rules = style.split(";").where((item) => item.trim().isNotEmpty);
    Style inlineStyle = Style();


    var isLink = false;
    var link = "";
    rules.forEach((String rule) {
      if (rule.indexOf(":") == -1) return;
      final parts = rule.split(":");
      String name = parts[0].trim();
      String value = parts[1].trim();
      switch (name.toLowerCase()) {
        case "color":
          inlineStyle = StyleGenUtils.addFontColor(inlineStyle, value);
          break;

        case "background-color":
          inlineStyle = StyleGenUtils.addBgColor(inlineStyle, value);
          break;

        case "font-weight":
          inlineStyle = StyleGenUtils.addFontWeight(inlineStyle, value);
          break;

        case "font-style":
          inlineStyle = StyleGenUtils.addFontStyle(inlineStyle, value);
          break;

        case "font-size":
          inlineStyle = StyleGenUtils.addFontSize(inlineStyle, value);
          break;

        case "text-decoration":
          inlineStyle = StyleGenUtils.addTextDecoration(inlineStyle, value);
          break;

        case "font-family":
          inlineStyle = StyleGenUtils.addFontFamily(inlineStyle, value);
          break;

        case "line-height":
          inlineStyle = StyleGenUtils.addLineHeight(inlineStyle, value);
          break;
        case "visit_link":
          isLink = true;
          link = TextGenUtils.getLink(value);
          break;
      }
    });
    return inlineStyle;
  }
}