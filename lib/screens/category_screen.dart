/// カテゴリ画面
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../models/rss_category.dart";
import "../providers/rss_providers.dart";


class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(rssCategoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("カテゴリ"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            key: ValueKey(category.id),
            title: Text(category.title),
            subtitle: Text(category.feedUrl),
            onTap: () {
              _onTapCategory(context, category);
            }
          );
        },
      ),
    );
  }

  void _onTapCategory(BuildContext context, RssCategory category) {
     final snackBar = SnackBar(
      content: Text("${category.title}を選択しました"),
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
    );
    // ScaffoldMessengerを使ってSnackBarを表示
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}