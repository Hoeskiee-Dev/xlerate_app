class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? dob;
  final String? avatar; // <-- Changed to avatar to match MockAPI

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.dob,
    this.avatar,
  });

  // --- Convert UserModel to a JSON Map ---
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'dob': dob,
      'avatar': avatar, // Saving to MockAPI as "avatar"
    };
  }

  // --- Create a UserModel from a JSON Map ---
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 'Learner',
      dob: json['dob'],
      avatar: json['avatar'], // Reading from MockAPI as "avatar"
    );
  }
}
