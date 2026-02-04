import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rss_app/models/rss_article.dart';
import 'package:rss_app/providers/rss_articles_providers.dart';

class ArticleListScreen extends ConsumerWidget {
  final String categoryId;

  const ArticleListScreen({
    super.key,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(rssArticlesProvider(categoryId));

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryId),
        backgroundColor: Colors.green,
      ),
      body: async.when(
          data: (articles) => _articleListView(articles),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
    );
  }

  Widget _articleListView(List<RssArticle> articles) {
    return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return ListTile(
            key: ValueKey(article.id),
            title: Text(article.title),
            subtitle: Text(article.link),
            onTap: () {
            },
          );
        },
      );
  }
}