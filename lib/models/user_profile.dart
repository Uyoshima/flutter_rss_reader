// ローカル登録用のユーザープロフィールモデル
class UserProfile {
  final String name;
  final String email;

  const UserProfile({
    required this.name,
    required this.email,
  });

  /// Hiveに保存しやすいようにMapに変換
  Map<String, dynamic> toJSON() => {"name": name, "email": email};

  /// Hiveから読み出したMapから復元
  static UserProfile? fromJSON(Map<String, dynamic>? json) {
    if (json == null) return null;
    return UserProfile(
      name: (json["name"] as String?) ?? "",
      email: (json["email"] as String?) ?? "",
    );
  }

}