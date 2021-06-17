import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:languageez_app/models/dictionary.dart';
import 'package:languageez_app/models/word.dart';
import 'package:languageez_app/repository/language_repository.dart';
import 'package:languageez_app/utility/badge_utility.dart';

class DictionaryController {

  List<String> dictionaries;
  Dictionary dictionary = Dictionary();
  List<Word> currWords = [];
  FlutterSecureStorage storage = new FlutterSecureStorage();
  BadgeController _badgeController = BadgeController();

  /// Retrieves a dictionary from the LanguagEz database
  getDictionaryLanguage(int languageId) async {
    dictionary = await getDictionary(languageId);
    currWords = dictionary.words;
  }

  /// Retrieves a dictionary from local storage
  getDictionaryLocal(String langName) async {
    List<Word> words = [];
    if(await storage.containsKey(key: langName)) {
      String wordString = await storage.read(key: langName);
      words = getWordList(wordString);
    }
    dictionary.words = words;
    currWords = dictionary.words;
  }

  /// Saves a new word to local storage
  saveWord(Word word, String langName) async {
    List<Word> words = [];
    if(await storage.containsKey(key: langName)) {
      String wordString = await storage.read(key: langName);
      words = getWordList(wordString);
    }
    word.id = words.isNotEmpty ? words.last.id++ : 0;
    words.add(word);
    await storage.write(key: langName, value: wordListToString(words));
    dictionary.words.add(word);
  }

  deleteWord(Word word, String langName) async {
    List<Word> words = dictionary.words;
    await storage.write(key: langName, value: wordListToString(words));
  }

  /// Transforms the list of words into a string that can be stored
  String wordListToString(List<Word> words) {
    String wordString = '';
    words.forEach((element) {
      wordString += '${jsonEncode(element)}';
    });
    return wordString.isNotEmpty ? wordString.substring(0, wordString.length-1) : null;
  }

  /// Returns a list of words from the string that has been stored
  List<Word> getWordList(String wordString){
    List<Word> words = [];
    wordString.split(']').forEach((element) {
      if(element.length > 2) {
        words.add(Word.fromJSON(jsonDecodePers(element)));
      }
    });
    return words;
  }

  /// Since I can't seem to find a way to store a json that the Decoder can
  /// interpret, I've decided to just do it myself.
  jsonDecodePers(String word) {
   if(word.length > 2) {
     word = word.substring(1);
     List<String> parameters = word.split(',');
     String aux = parameters[3].trim().substring(14).trim();
     Map<String, dynamic> tr_word = {
       '0' :  aux.substring(0, aux.length-1)
     };
     Map<String, dynamic> param = {
       "id" : parameters[0].split(':')[1].trim(),
       "og_word" : parameters[1].split(':')[1].trim(),
       "pr_word" : parameters[2].split(':')[1].trim(),
       "tr_word" : tr_word,
     };
     print('PARAM: $param');
     return param;
   }
   return {};
  }

  /// Deletes a local dictionary
  deleteDic(String name) async {
    List<String> dictionaries = [];
    if(await storage.containsKey(key: 'dictionaries')) {
    dictionaries = (await storage.read(key: 'dictionaries')).split(',');
    }
    dictionaries.remove(name);
    String newDic = '';
    dictionaries.forEach((element) {
      newDic += '$element,';
    });
    print(newDic);
    print(newDic.replaceAll(', ', ''));
    await storage.write(key: 'dictionaries', value: newDic.isNotEmpty ? newDic.substring(0, newDic.length-1) : null);
  }

  /// Load a list of local dictionaries
  Future<List<String>> loadDictionariesLocal() async {
    List<String> dictionaries = [];
    if(await storage.containsKey(key: 'dictionaries')) {
    dictionaries = (await storage.read(key: 'dictionaries')).split(',');
    }
    return dictionaries;
  }

  /// Save local dictionary
  Future<bool> saveDictionary(String name) async {
    print('WORD: $name');
    List<String> dictionaries = [];
    if(await storage.containsKey(key: 'dictionaries')) {
      dictionaries = (await storage.read(key: 'dictionaries')).split(',');
    }
    print(dictionaries);
    if(dictionaries.contains(name)) {
      return false;
    } else {
      String newDic = name + ',';
      dictionaries.forEach((element) {
        newDic += '$element,';
      });
      print(newDic);
      print(newDic.replaceAll(', ', ''));
      await storage.write(key: 'dictionaries', value: newDic.substring(0, newDic.length-1));
      int numberDics = 0;
      if(await storage.containsKey(key: 'dictionariesCreated'))
        numberDics =  int.parse(await storage.read(key: 'dictionariesCreated'));
      numberDics++;
      await storage.write(key: 'dictionariesCreated', value: numberDics.toString());
      _badgeController.checkDictionaryCreated(numberDics);
      return true;
    }
  }

  /// Filters all words
  filter(String filter) {
    this.currWords = [];
    dictionary.words.forEach((element) {
      if(element.og_word.contains(filter)) {
        currWords.add(element);
      }
    });
  }
}