class GiphyUtils {
  static List<RegExp> REGEX_LIST = [
    RegExp(
        '^(https?://(www\\.)?)?media\\.giphy\\.com/media/(?<id>\\w+)/giphy\\.gif'),
    RegExp(
        '^(https?://(www\\.)?)?media\\d+\\.giphy\\.com/media/(?<id>\\w+)/giphy\\.gif'),
    RegExp('^(https?://(www\\.)?)?giphy\\.com/gifs/(\\w+)-(?<id>\\w+)'),
    RegExp('^(https?://(www\\.)?)?giphy\\.com/embed/(?<id>\\w+)'),
  ];

  static String getId(String url) {
    return REGEX_LIST
        .where((regex) => regex.hasMatch(url))
        .map((regex) => regex.firstMatch(url))
        .map((match) => match.namedGroup("id"))
        .firstWhere((element) => true, orElse: () => null);
  }

  static String buildGifUrlFromId(String id) {
    return 'https://i.giphy.com/$id.gif';
  }
}
