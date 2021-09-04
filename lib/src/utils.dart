import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

Map<String, String> namedColors = {
  "White": "#FFFFFF",
  "Silver": "#C0C0C0",
  "Gray": "#808080",
  "Black": "#000000",
  "Red": "#FF0000",
  "Maroon": "#800000",
  "Yellow": "#FFFF00",
  "Olive": "#808000",
  "Lime": "#00FF00",
  "Green": "#008000",
  "Aqua": "#00FFFF",
  "Teal": "#008080",
  "Blue": "#0000FF",
  "Navy": "#000080",
  "Fuchsia": "#FF00FF",
  "Purple": "#800080",
};

Map<String, String> mathML2Tex = {
  "sin": r"\sin",
  "sinh": r"\sinh",
  "csc": r"\csc",
  "csch": r"csch",
  "cos": r"\cos",
  "cosh": r"\cosh",
  "sec": r"\sec",
  "sech": r"\sech",
  "tan": r"\tan",
  "tanh": r"\tanh",
  "cot": r"\cot",
  "coth": r"\coth",
  "log": r"\log",
  "ln": r"\ln",
};

class Context<T> {
  T data;

  Context(this.data);
}

// This class is a workaround so that both an image
// and a link can detect taps at the same time.
class MultipleTapGestureDetector extends InheritedWidget {
  final void Function()? onTap;

  const MultipleTapGestureDetector({
    Key? key,
    required Widget child,
    required this.onTap,
  }) : super(key: key, child: child);

  static MultipleTapGestureDetector? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MultipleTapGestureDetector>();
  }

  @override
  bool updateShouldNotify(MultipleTapGestureDetector oldWidget) => false;
}

class CustomBorderSide {
  CustomBorderSide({
    this.color = const Color(0xFF000000),
    this.width = 1.0,
    this.style = BorderStyle.none,
  }) : assert(width >= 0.0);

  Color? color;
  double width;
  BorderStyle style;
}

String getRandString(int len) {
  var random = Random.secure();
  var values = List<int>.generate(len, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

Size calcSize(BuildContext context, double w, double h, double ratio) {
  final Size screenSize = MediaQuery.of(context).size;
  double? screenWidth;
  double? screenHeight;

  if (!screenSize.isEmpty && screenSize.isFinite) {
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
  }

  if (screenWidth != null && w > screenWidth) {
    w = screenWidth;
    h = w / ratio;
  }

  if (screenHeight != null && h > screenHeight) {
    w = screenHeight * ratio;
    h = screenHeight;
  }

  return new Size(w, h);
}

class GiphyUtils {
  static final List<RegExp> URL_REGEX_LIST = [
    RegExp('^(https?://(www\\.)?)?media\\.giphy\\.com/media/(?<id>\\w+)/giphy\\.gif'),
    RegExp('^(https?://(www\\.)?)?media\\d+\\.giphy\\.com/media/(?<id>\\w+)/giphy\\.gif'),
    RegExp('^(https?://(www\\.)?)?giphy\\.com/gifs/(\\w+)-(?<id>\\w+)'),
    RegExp('^(https?://(www\\.)?)?giphy\\.com/embed/(?<id>\\w+)'),
  ];

  GiphyUtils._();

  static String? getId(String url) {
    return URL_REGEX_LIST
        .where((regex) => regex.hasMatch(url))
        .map((regex) => regex.firstMatch(url))
        .where((element) => element != null)
        .map((match) => match?.namedGroup("id"))
        .firstWhere((element) => true, orElse: () => null);
  }

  static String builUrlFromId(String id) {
    return 'https://i.giphy.com/$id.gif';
  }
}

class YoutubeUtils {
  static final URL_REGEXP_LIST = [
    RegExp(r"v=([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(r"^embed\/([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(r"\/([_\-a-zA-Z0-9]{11}).*$")
  ];
  static const String YT_THUMBNAIL_HOST = "https://img.youtube.com/vi/";
  static const String YT_THUMBNAIL_IMG = "/mqdefault.jpg";

  YoutubeUtils._();

  static bool isYoutubeUrl(url) {
    return getYoutubeId(url) != null;
  }

  /// Converts fully qualified YouTube Url to video id.
  static String? getYoutubeId(String url) {
    try {
      if ((url.contains('youtube.com') || url.contains('youtu.be'))) {
        for (var exp in URL_REGEXP_LIST) {
          Match? match = exp.firstMatch(url);
          if (match != null && match.groupCount >= 1) return match.group(1);
        }
      }
      return null;
    } catch (ex) {
      return null;
    }
  }

  static String? getYoutubeThumbnail(String url) {
    try {
      final String? youtubeId = YoutubeUtils.getYoutubeId(url);
      if (youtubeId == null || youtubeId.isEmpty) return null;
      return '$YT_THUMBNAIL_HOST$youtubeId$YT_THUMBNAIL_IMG';
    } catch (ex) {
      return null;
    }
  }

  //youtubeId: id video yotuube
  // return url of thumbnail or null
  static String? getYoutubeThumbnailById(String? youtubeId) {
    if (youtubeId == null) return null;
    return '$YT_THUMBNAIL_HOST$youtubeId$YT_THUMBNAIL_IMG';
  }
}
