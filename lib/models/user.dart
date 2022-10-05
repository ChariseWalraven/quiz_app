class User {
  final String userName;
  final String? email;
  String? photoURL;

  User({required this.userName, required this.photoURL, required this.email});

  get displayName => userName;
}
