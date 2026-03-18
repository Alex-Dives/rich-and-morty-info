import 'package:hive/hive.dart';
import 'package:rick_and_morty_info/database/models/info.model.dart';
import 'package:rick_and_morty_info/database/models/profile.model.dart';

part 'character_list.model.g.dart';

@HiveType(typeId: 2)
class CharacterListModel {
  @HiveField(0)
  InfoModel? info;

  @HiveField(1)
  List<ProfileModel>? results;

  CharacterListModel({
    this.info,
    this.results,
  });

  factory CharacterListModel.fromMap(Map<String, dynamic> map) {
    return CharacterListModel(
      info: map['info'] != null ? InfoModel.fromMap(map['info'] as Map<String, dynamic>) : null,
      results: map['results'] != null
          ? (map['results'] as List<dynamic>)
          .map((e) => ProfileModel.fromMap(e as Map<String, dynamic>))
          .toList()
          : null,
    );
  }
}