import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:hive/hive.dart";

import "../models/user_profile.dart";

const _boxName = "app_Box";
const _keyProfile = "profile";

/// HiveのBoxをアプリ全体で使い回すためのProvider
final boxProvider = Provider<Box<dynamic>>((ref) {
  // main.dartでopen済みのBoxを取得するだけ
  return Hive.box<dynamic>(_boxName);
});

/// ユーザー情報
/// - null: 未登録
/// - non-null: 登録済み
final userProfileProvider = StateNotifierProvider<UserProfileNotifier, UserProfile?>(
  (ref) => UserProfileNotifier(ref.read(boxProvider)),
);

class UserProfileNotifier extends StateNotifier<UserProfile?> {
  final Box<dynamic> box;

  UserProfileNotifier(this.box) 
  : super(
    UserProfile.fromJSON(
      (box.get(_keyProfile) as Map?)?.cast<String, dynamic>()
    ),
    );

  /// 登録内容を保存して、stateも更新する
  void save(UserProfile profile) {
    box.put(_keyProfile, profile.toJSON());
    state = profile;
  }
}