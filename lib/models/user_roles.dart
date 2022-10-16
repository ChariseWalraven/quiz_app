/// The UserRoles model for the firestore userRoles collection
class UserRoles {
  final bool isAdmin;

  UserRoles({required this.isAdmin});

  factory UserRoles.fromJson(json) {
    return UserRoles(
      isAdmin: json["isAdmin"] ?? false,
    );
  }
}
