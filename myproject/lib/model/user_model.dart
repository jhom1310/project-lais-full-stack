class User {
  int id;
  String email;
  String access;
  String refresh;

  User({
    required this.id,
    required this.email,
    required this.access,
    required this.refresh,
  });

  factory User.fromDatabaseJson(Map<String, dynamic> data) => User(
        id: data['id'],
        email: data['email'],
        access: data['access'],
        refresh: data['refres'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "email": this.email,
        "access": this.access,
        "refresh": this.refresh
      };
}
