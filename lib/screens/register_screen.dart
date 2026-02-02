/// ユーザー登録画面

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../models/user_profile.dart";
import "../providers/storage_providers.dart";

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ユーザー登録"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _name,
              decoration: const InputDecoration(labelText: "名前"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: "メールアドレス"),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final name = _name.text;
                final email = _email.text;
                // 入力チェック
                if (name.isEmpty || email.isEmpty) return;
                // Riverpod経由で保存
                ref
                  .read(userProfileProvider.notifier)
                  .save(UserProfile(name: name, email: email));
                // カテゴリ画面へ遷移
                context.go("/categories");
              },
              child: const Text("登録してはじめる"),
            ),
          ],
        ),
      ),
    );
  }
}