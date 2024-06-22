import "package:equatable/equatable.dart";

class User extends Equatable {
  final int id;
  final String name;
  final String email;


  const User({required this.id, required this.name, required this.email});

  @override
  List<Object?> get props => [id, name, email];

  factory User.fromJson(json) {
    return User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
    );
  }

  factory User.fromToken(json) {
    return User(
      id: int.parse(json["id"]),
      name: json["name"],
      email: json["email"],
    );
  }


}