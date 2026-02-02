import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:hive_flutter/hive_flutter.dart";

import "app_router.dart";

Future<void> main() async {
  // Flutterエンジンの初期化を保証
  WidgetsFlutterBinding.ensureInitialized();

  // Hiveの初期化とBoxを開く
  await Hive.initFlutter();
  await Hive.openBox<dynamic>("app_Box");

  // Riverpodのルート
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: "RSS リーダー",
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue),
      routerConfig: router,
    );
  }
}