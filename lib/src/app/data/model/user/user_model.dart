class UserModel {
  final String id;
  final String username;
  final String password;
  final String name;

  UserModel({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String docId) {
    return UserModel(
      id: docId,
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      name: map['name'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'name': name,
    };
  }
}
