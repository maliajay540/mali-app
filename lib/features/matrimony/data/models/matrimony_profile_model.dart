// data/models/matrimony_profile_model.dart

import '../../domain/entities/matrimony_profile_entity.dart';

class MatrimonyProfileModel extends MatrimonyProfileEntity {
  MatrimonyProfileModel({
    required super.id,
    required super.name,
    required super.age,
    required super.city,
    required super.profession,
    required super.image,
  });

  factory MatrimonyProfileModel.fromJson(Map<String, dynamic> json) {
    return MatrimonyProfileModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      city: json['city'],
      profession: json['profession'],
      image: json['image'],
    );
  }
}