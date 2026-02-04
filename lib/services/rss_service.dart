import "../models/rss_article.dart";
import "package:http/http.dart" as http;
import "package:webfeed/webfeed.dart";

class RssService {
  // RSSフィードを取得してパースするメソッド
  static Future<List<RssArticle>> fetchRssArticles(String feedUrl) async {
    final uri = Uri.parse(feedUrl);
    final response = await http.get(uri);
    if (response.statusCode != 200) throw Exception("Failed to load RSS feed. status: ${response.statusCode}, feedUrl: $feedUrl");
    
    final feed = RssFeed.parse(response.body);

    if (feed.items == null || feed.items!.isEmpty) return [];

    return feed.items!.map((item) {
      if (item.link == null ||  item.link!.isEmpty) {
        return null;
      }
      return RssArticle(
        id: "${item.link}_${item.pubDate ?? "no_date"}",
        title: item.title ?? "No Title",
        link: item.link!,
      );
    }).whereType<RssArticle>().toList();
  }
}