# rick_and_morty_info

## Необходимая версия flutter / dart
Flutter - 3.38.4
Dart - 3.10.3

## Билд приложения

1. Запустить команду ```flutter pub get```
2. Запустить генерацию ```flutter pub run build_runner build --delete-conflicting-outputs``` 
3. Сборка apk ```flutter build apk --release --split-per-abi```
4. Сборка aab ```flutter build appbundle --release```
5. Сборка ipa ```flutter build ipa --release```