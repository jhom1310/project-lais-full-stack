class UserLogin {
  String email;
  String password;

  UserLogin({required this.email, required this.password});

  Map<String, dynamic> toDatabaseJson() =>
      {"email": this.email, "password": this.password};
}

class Token {
  String access;
  String refresh;

  Token({required this.access, required this.refresh});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      access: json['access'],
      refresh: json['refresh'],
    );
  }
}
