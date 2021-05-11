class GiphyUtils {
  static final List<RegExp> gifphyUrlRegexes = [
    RegExp('^(https?://(www\\.)?)?media\\.giphy\\.com/media/(?<id>\\w+)/giphy\\.gif'),
    RegExp('^(https?://(www\\.)?)?media\\d+\\.giphy\\.com/media/(?<id>\\w+)/giphy\\.gif'),
    RegExp('^(https?://(www\\.)?)?giphy\\.com/gifs/(\\w+)-(?<id>\\w+)'),
    RegExp('^(https?://(www\\.)?)?giphy\\.com/embed/(?<id>\\w+)'),
  ];

  static String? getId(String url) {
    return gifphyUrlRegexes
        .where((regex) => regex.hasMatch(url))
        .map((regex) => regex.firstMatch(url))
        .where((element) => element != null)
        .map((match) => match?.namedGroup("id"))
        .firstWhere((element) => true, orElse: () => null);
  }

  static String buildGifUrlFromId(String id) {
    return 'https://i.giphy.com/$id.gif';
  }
}
