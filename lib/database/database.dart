import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty_info/database/models/character_list.model.dart';
import 'package:rick_and_morty_info/database/models/info.model.dart';
import 'package:rick_and_morty_info/database/models/profile.model.dart';

class HiveDataBase {

  factory HiveDataBase() => _instance;

  const HiveDataBase._internal();

  Future<void> initHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ProfileModelAdapter());
    Hive.registerAdapter(InfoModelAdapter());
    Hive.registerAdapter(CharacterListModelAdapter());

    await Hive.openBox<ProfileModel>('favorites');
    await Hive.openBox<ProfileModel>('all_characters');
  }

  static const HiveDataBase _instance = HiveDataBase._internal();
}