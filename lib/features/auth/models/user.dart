/// User returned by the API on login: { "id", "fullName", "email" }.
class User {
  final int id;
  final String fullName;
  final String email;

  const User({required this.id, required this.fullName, required this.email});

  /// Builds a User from the JSON map of the API.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
    );
  }
}
