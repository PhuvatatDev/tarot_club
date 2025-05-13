class AppUser {
  final String uid;
  final String email;

  AppUser({
    required this.uid,
    required this.email,
  });

  // methode to convert app user -> json
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
    };
  }

  // methode to covert json to app user
  factory AppUser.formJson(Map<String, dynamic> jsonUser) {
    return AppUser(
      uid: jsonUser["uid"], 
      email: jsonUser["email"],
      );
  }
}
