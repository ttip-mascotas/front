import "package:equatable/equatable.dart";
import "package:mascotas/model/pet.dart";
import "package:mascotas/model/user.dart";

class Group extends Equatable {
  final int id;
  final String name;
  final List<User> members;
  final List<Pet> pets;

  const Group({
    required this.id,
    required this.name,
    required this.members,
    required this.pets,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        members,
        pets,
      ];

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json["id"],
      name: json["name"],
      members: _membersFromJson(json["members"]),
      pets: _petsFromJson(json["pets"]),
    );
  }

  static List<User> _membersFromJson(List<dynamic>? json) {
    if (json != null) {
      return json
          .map<User>((json) => User.fromJson(json))
          .toList();
    }
    return [];
  }
  static List<Pet> _petsFromJson(List<dynamic>? json) {
    if (json != null) {
      return json
          .map<Pet>((json) => Pet.fromJson(json))
          .toList();
    }
    return [];
  }
}
