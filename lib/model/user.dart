import 'dart:convert';

class UsersModel {

  String id_user;
  String name;
  String email;
  String picture;
  String address;
  String date_of_birth;
  String telephone;
  String role;
  String creation_date;
  String update_date;


  UsersModel(
      {required this.id_user,
      required this.name,
      required this.email,
      required this.picture,
      required this.address,
      required this.date_of_birth,
      required this.telephone,
      required this.role,
      required this.creation_date,
      required this.update_date});


  factory UsersModel.fromJson(Map<String, dynamic> map) {
    return UsersModel(
        id_user: map["id_user"],
        name: map["name"],
        email: map["email"],
        picture: map["picture"],
        address: map["address"],
        date_of_birth: map["date_of_birth"],
        telephone: map["telephone"],
        role: map["role"],
        creation_date: map["creation_date"],
        update_date: map["update_date"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_user": id_user,
      "name": name,
      "email": email,
      "picture": picture,
      "address": address,
      "date_of_birth": date_of_birth,
      "telephone": telephone,
      "role": role,
      "creation_date": creation_date,
      "update_date": update_date
    };
  }

  @override
  String toString() {
    return 'Users{id_user: $id_user, name: $name, email: $email, picture: $picture, address: $address, date_of_birth: $date_of_birth, telephone: $telephone, role : $role, creation_date: $creation_date, update_date: $update_date,}';
  }
}

List<UsersModel> userFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<UsersModel>.from(data.map((item) => UsersModel.fromJson(item)));
}

String userToJson(UsersModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}