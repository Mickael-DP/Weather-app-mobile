import 'package:shared_preferences/shared_preferences.dart';

class DataPersistence {
  final key = "cities_sp_key";

  // Obtenir les villes sauvegardées
  Future<List<String>> getCities() async {
    final preferences = await SharedPreferences.getInstance();
    final list = preferences.getStringList(key);
    return list ?? [];
  }

  // Ajouter une ville
  Future<bool> addCity(String string) async {
    final prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList(key) ?? [];
    if (!list.contains(string)) {
      list.add(string);
      return prefs.setStringList(key, list);
    } else {
      return false;
    }
  }
}
