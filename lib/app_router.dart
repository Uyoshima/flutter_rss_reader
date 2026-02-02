import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "providers/storage_providers.dart";
import "screens/register_screen.dart";
import "screens/category_screen.dart";

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