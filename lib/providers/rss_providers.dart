import "package:flutter_riverpod/flutter_riverpod.dart";

import "../models/rss_category.dart";


final rssCategoryProvider = Provider<List<RssCategory>>((ref) {
  
  return [
    const RssCategory(id: "1", title: "国内", feedUrl: "https://news.yahoo.co.jp/rss/topics/domestic.xml"),
    const RssCategory(id: "2", title: "国際", feedUrl: "https://news.yahoo.co.jp/rss/topics/world.xml"),
    const RssCategory(id: "3", title: "経済", feedUrl: "https://news.yahoo.co.jp/rss/topics/business.xml"),
  ];
});