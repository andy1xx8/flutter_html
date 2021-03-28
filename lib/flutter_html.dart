library flutter_html;

import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/image_render.dart';
import 'package:flutter_html/style.dart';
import 'package:html/dom.dart' as dom;
import 'package:webview_flutter/webview_flutter.dart';

class Html extends StatelessWidget {
  /// The `Html` widget takes HTML as input and displays a RichText
  /// tree of the parsed HTML content.
  ///
  /// **Attributes**
  /// **data** *required* takes in a String of HTML data (required only for `Html` constructor).
  /// **document** *required* takes in a Document of HTML data (required only for `Html.fromDom` constructor).
  ///
  /// **onLinkTap** This function is called whenever a link (`<a href>`)
  /// is tapped.
  /// **customRender** This function allows you to return your own widgets
  /// for existing or custom HTML tags.
  /// See [its wiki page](https://github.com/Sub6Resources/flutter_html/wiki/All-About-customRender) for more info.
  ///
  /// **onImageError** This is called whenever an image fails to load or
  /// display on the page.
  ///
  /// **shrinkWrap** This makes the Html widget take up only the width it
  /// needs and no more.
  ///
  /// **onImageTap** This is called whenever an image is tapped.
  ///
  /// **blacklistedElements** Tag names in this array are ignored during parsing and rendering.
  ///
  /// **style** Pass in the style information for the Html here.
  /// See [its wiki page](https://github.com/Sub6Resources/flutter_html/wiki/Style) for more info.
  Html({
    Key? key,
    required this.data,
    this.onLinkTap,
    this.customRender = const {},
    this.customImageRenders = const {},
    this.onImageError,
    this.onMathError,
    this.shrinkWrap = false,
    this.onImageTap,
    this.blacklistedElements = const [],
    this.style = const {},
    this.navigationDelegateForIframe,
    this.headers,
    this.configs,
  })  : document = null,
        assert(data != null),
        super(key: key);

  Html.fromDom({
    Key? key,
    @required this.document,
    this.onLinkTap,
    this.customRender = const {},
    this.customImageRenders = const {},
    this.onImageError,
    this.onMathError,
    this.shrinkWrap = false,
    this.onImageTap,
    this.blacklistedElements = const [],
    this.style = const {},
    this.navigationDelegateForIframe,
    this.headers,
    this.configs,
  })  : data = null,
        assert(document != null),
        super(key: key);

  /// The HTML data passed to the widget as a String
  final String? data;

  /// The HTML data passed to the widget as a pre-processed [dom.Document]
  final dom.Element? document;

  /// A function that defines what to do when a link is tapped
  final OnTap? onLinkTap;

  /// An API that allows you to customize the entire process of image rendering.
  /// See the README for more details.
  final Map<ImageSourceMatcher, ImageRender> customImageRenders;

  /// A function that defines what to do when an image errors
  final ImageErrorListener? onImageError;

  /// A function that defines what to do when either <math> or <tex> fails to render
  /// You can return a widget here to override the default error widget.
  final OnMathError? onMathError;

  /// A parameter that should be set when the HTML widget is expected to be
  /// flexible
  final bool shrinkWrap;
  final Map<String, String>? headers;
  final Map<String, dynamic>? configs;

  /// A function that defines what to do when an image is tapped
  final OnTap? onImageTap;

  /// A list of HTML tags that defines what elements are not rendered
  final List<String> blacklistedElements;

  /// Either return a custom widget for specific node types or return null to
  /// fallback to the default rendering.
  final Map<String, CustomRender> customRender;

  /// An API that allows you to override the default style for any HTML element
  final Map<String, Style> style;

  /// Decides how to handle a specific navigation request in the WebView of an
  /// Iframe. It's necessary to use the webview_flutter package inside the app
  /// to use NavigationDelegate.
  final NavigationDelegate? navigationDelegateForIframe;

  @override
  Widget build(BuildContext context) {
    final dom.Element doc =
        data != null ? HtmlParser.parseHTML(data!).documentElement! : document!;
    final double? width = shrinkWrap ? null : MediaQuery.of(context).size.width;

    return Container(
      width: width,
      child: HtmlParser(
        htmlData: doc,
        onLinkTap: onLinkTap,
        onImageTap: onImageTap,
        onImageError: onImageError,
        onMathError: onMathError,
        shrinkWrap: shrinkWrap,
        style: style,
        customRender: customRender,
        imageRenders: {}
          ..addAll(customImageRenders)
          ..addAll(defaultImageRenders),
        blacklistedElements: blacklistedElements,
        navigationDelegateForIframe: navigationDelegateForIframe,
        headers: headers,
        configs: configs,
      ),
    );
  }
}
