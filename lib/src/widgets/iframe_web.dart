// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/src/replaced_element.dart';
import 'package:flutter_html/src/utils.dart';
import 'package:flutter_html/style.dart';
import 'package:html/dom.dart' as dom;
import 'package:webview_flutter/webview_flutter.dart';

/// [IframeContentElement is a [ReplacedElement] with web content.
class IframeContentElement extends ReplacedElement {
  final String? src;
  final double? width;
  final double? height;
  final NavigationDelegate? navigationDelegate;
  final UniqueKey key = UniqueKey();
  final String createdViewId = getRandString(10);

  final Map<String, String>? headers;

  IframeContentElement({
    required String name,
    required this.src,
    required this.width,
    required this.height,
    required dom.Element node,
    required this.navigationDelegate,
    this.headers,
  }) : super(name: name, style: Style(), node: node);

  @override
  Widget toWidget(RenderContext context) {
    final html.IFrameElement iframe = html.IFrameElement()
      ..width = (width ?? (height ?? 150) * 2).toString()
      ..height = (height ?? (width ?? 300) / 2).toString()
      ..src = src
      ..style.border = 'none';
    //not actually an error
    ui.platformViewRegistry
        .registerViewFactory(createdViewId, (int viewId) => iframe);
    return Container(
        width: width ?? (height ?? 150) * 2,
        height: height ?? (width ?? 300) / 2,
        child: Directionality(
            textDirection: TextDirection.ltr,
            child: HtmlElementView(
              viewType: createdViewId,
            )));
  }
}
