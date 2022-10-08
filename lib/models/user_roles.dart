/// The UserRoles model for the firestore userRoles collection
class UserRoles {
  final bool isAdmin;

  UserRoles({required this.isAdmin});

  factory UserRoles.fromJson(json) {
    print(json["isAdmin"]);
    return UserRoles(
      isAdmin: json["isAdmin"] ?? false,
    );
  }
}
