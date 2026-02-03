import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/articles_providers.dart';

class ArticleListScreen extends ConsumerWidget {
  final String categoryId;

  const ArticleListScreen({
    super.key,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articles = ref.watch(articlesProvider(categoryId));

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryId),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
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
      ),
    );
  }
}