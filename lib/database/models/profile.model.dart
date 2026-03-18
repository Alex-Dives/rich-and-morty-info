import 'package:hive/hive.dart';

part 'profile.model.g.dart';

@HiveType(typeId: 0)
class ProfileModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? status;

  @HiveField(3)
  String? species;

  @HiveField(4)
  String? type;

  @HiveField(5)
  String? gender;

  @HiveField(6)
  String? image;

  ProfileModel({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.image,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as int?,
      name: map['name'] as String?,
      status: map['status'] as String?,
      species: map['species'] as String?,
      type: map['type'] as String?,
      gender: map['gender'] as String?,
      image: map['image'] as String?,
    );
  }
}