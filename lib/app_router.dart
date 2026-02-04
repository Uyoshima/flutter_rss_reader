import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "providers/storage_providers.dart";
import "screens/register_screen.dart";
import "screens/category_screen.dart";
import "screens/article_list_screen.dart";
import "screens/webview_screen.dart";

/// GoRouterをProviderとして提供する
final routerProvider =  Provider<GoRouter>((ref) {
  //  ユーザー登録情報の状態を監視
  final profile = ref.watch(userProfileProvider);
  return GoRouter(
    // 初期画面をユーザー登録済みかどうかで切り替え
    initialLocation: profile == null ? "/register" : "/categories",
    routes: [
      GoRoute(
        path: "/register",
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: "/categories",
        builder: (context, state) => const CategoryScreen(),
      ),
      GoRoute(
        path: "/categories/:id",
        builder: (context, state) {
          return ArticleListScreen(categoryId: state.pathParameters["id"]!);
        },
      ),
      GoRoute(
        path: "/webview",
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final url = extra?["url"] as String?;
          final title = extra?["title"] as String?;

          // extra が渡されていない／型が違うなどのケースでクラッシュしないようにガード
          if (url == null || url.isEmpty || title == null) {
            return const CategoryScreen();
          }

          return WebViewScreen(url: url, title: title);
        },
      )
    ],

    // ルート遷移時に毎回呼ばれる。状況に応じてリダイレクトを行う
    redirect: (context, state) {
      final isRegister = state.matchedLocation == "/register";
      final hasProfile = profile != null;

      // 未登録なのにregister以外へ行こうとしたらregisterへリダイレクト
      if (!hasProfile && !isRegister) return "/register";
      // 登録済みなのにregisterへ行こうとしたらcategoriesへリダイレクト
      if (hasProfile && isRegister) return "/categories";

      return null; // リダイレクトなし
    },
  );
});