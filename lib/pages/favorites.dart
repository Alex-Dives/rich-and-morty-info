import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty_info/database/models/profile.model.dart';
import 'package:rick_and_morty_info/pages/widgets/person_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<ProfileModel>>(
      valueListenable: Hive.box<ProfileModel>('favorites').listenable(),
      builder: (context, box, _) {
        final favorites = box.values.toList();

        if (favorites.isEmpty) {
          return const Center(
            child: Text(
              'Пока ничего не добавлено в избранное\nНажми на звёздочку на карточке',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.75, // чуть выше, чем квадрат, если нужно
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            return PersonCard(profile: favorites[index]);
          },
        );
      },
    );
  }
}