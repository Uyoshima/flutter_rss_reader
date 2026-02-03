import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/rss_article.dart';

/// RSS記事プロバイダー
/// カテゴリーidに基づいて記事のリストを提供する
final articlesProvider = Provider.family<List<RssArticle>, String>((ref, id) {
  // TODO: カテゴリーIDに基づいて記事を取得する
  // ダミーの記事データを返す
  return [
    const RssArticle(
      id: "1",
      title: '記事タイトル 1',
      link: 'https://example.com/article/1',
    ),
    const RssArticle(
      id: "2",
      title: '記事タイトル 2',
      link: 'https://example.com/article/2',
    ),const RssArticle(
      id: "3",
      title: '記事タイトル 3',
      link: 'https://example.com/article/3',
    ),
  ];
});