import 'package:untitled/feature/auth/domain/entity/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.email, required super.name});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(id: map['id'], email: map['email'], name: map['name'] ?? '');
  }

  User toUser() {
    return User(id: id, email: email, name: name);
  }
}
