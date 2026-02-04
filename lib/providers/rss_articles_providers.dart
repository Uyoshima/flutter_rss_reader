
import "package:flutter_riverpod/flutter_riverpod.dart";

import "rss_providers.dart";
import "../services/rss_service.dart";
import "../models/rss_article.dart";


final rssArticlesProvider = FutureProvider.family<List<RssArticle>, String>((ref, categoryId) async {
  final rssCategory = ref.watch(rssCategoryProvider).firstWhere(
    (category) => category.id == categoryId,
    orElse: () => throw Exception("unknown categoryId: $categoryId"),
  );
  
  final articles = await RssService.fetchRssArticles(rssCategory.feedUrl);
  
  return articles;
});