import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {

  const UserModel({
    required super.id,
    required super.phone,
    required super.name,
    required super.profileCompleted,
  });

 factory UserModel.fromJson(Map<String,dynamic> json){
  return UserModel(
    id: int.tryParse(json["id"].toString()) ?? 0,
    phone: json["phone"] ?? "",
    name: json["name"] ?? "",
    profileCompleted: json["profile_complete"].toString() == "1",
  );
}

}