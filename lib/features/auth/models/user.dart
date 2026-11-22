/// User returned by the API on login: { "id", "name", "email" }.
class User {
  final int id;
  final String fullName;
  final String email;

  const User({required this.id, required this.fullName, required this.email});

  /// Builds a User from the JSON map of the API.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      // The docs say "fullName", but the real API (database column) sends
      // "name". We accept both so the app works in any case.
      fullName: (json['fullName'] ?? json['name']) as String,
      email: json['email'] as String,
    );
  }
}
