class AppUser {
  final String uid;
  final String email;
  final String? name;

  AppUser({
    required this.uid,
    required this.email,
    this.name,
  });

  // méthode pour convertir AppUser → JSON
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
    };
  }

  // méthode pour convertir JSON → AppUser
  factory AppUser.fromJson(Map<String, dynamic> jsonUser) {
    return AppUser(
      uid: jsonUser["uid"],
      email: jsonUser["email"],
      name: jsonUser["name"],
    );
  }
}
