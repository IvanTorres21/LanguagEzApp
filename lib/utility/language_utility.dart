
import 'package:languageez_app/models/language.dart';
import 'package:languageez_app/repository/language_repository.dart';

class LanguageController {

  List<Language> languages = [];
  Language language;

  Future<void> receiveLanguages() async {
      languages = await getLanguages();
      print(languages);
  }

  Future<void> receiveLanguage(int id) async {
    language = await getLanguage(id);
  }

  Future<void> tryAssign(int id) async {
    language.assigned = await assignLanguage(id);
  }
}