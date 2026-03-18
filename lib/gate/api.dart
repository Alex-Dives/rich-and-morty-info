import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty_info/database/models/character_list.model.dart';
import 'package:rick_and_morty_info/database/models/profile.model.dart';

class Api {
  final String host = 'https://rickandmortyapi.com/api';
  final dio = Dio();

  Future<CharacterListModel> getCards({int page = 1}) async {
    final url = '$host/character?page=$page';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final model = CharacterListModel.fromMap(data);

        final cacheBox = Hive.box<ProfileModel>('all_characters');
        for (var p in model.results ?? []) {
          if (p.id != null) {
            await cacheBox.put(p.id.toString(), p);
          }
        }

        return model;
      } else {
        throw Exception('Ошибка: ${response.statusCode}');
      }
    } catch (e) {
      print('Ошибка при запросе: $e');
      rethrow;
    }
  }
}