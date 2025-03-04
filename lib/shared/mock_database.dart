import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  static const String _key = "tasks";

// Überschreiben der bestehenden Methoden
  @override
// Hinzufügefunktion
  Future<void> addItem(String item) async {
// Zugriff auf SharedPref-Instanz
    final prefs = await SharedPreferences.getInstance();
// Auslesen der bestehenden Liste
    final tasks = prefs.getStringList(_key) ?? [];
//Hinzufügen von einer neuen Task
    tasks.add(item);
// Liste neu speichern
    await prefs.setStringList(_key, tasks);
  }

  @override
//Löschfunktion
  Future<void> deleteItem(int index) async {
// Zugriff auf SharedPref-Instanz
    final prefs = await SharedPreferences.getInstance();
// Auslesen der bestehenden Liste
    final tasks = prefs.getStringList(_key) ?? [];
// Löschen der Task
    tasks.removeAt(index);
// Liste neu speichern/aktualisieren
    await prefs.setStringList(_key, tasks);
  }

  @override
//Bearbeitefunktion
  Future<void> editItem(int index, String newItem) async {
// Zugriff auf SharedPref-Instanz
    final prefs = await SharedPreferences.getInstance();
// Auslesen der bestehenden Liste
    final tasks = prefs.getStringList(_key) ?? [];
// Bearbeiten der Task
    if (index >= 0 && index < tasks.length) {
      tasks[index] = newItem;
// Liste neu Speichern / aktualisieren
      await prefs.setStringList(_key, tasks);
    } else {
      print("Falscher Index ($index)");
    }
  }

  @override
  //Abfragefunktion
  Future<List<String>> getItems() async {
// Zugriff auf SharedPref-Instanz
    final prefs = await SharedPreferences.getInstance();
// Auslesen der bestehenden Liste
    final tasks = prefs.getStringList(_key) ?? [];
// Zurückgeben (ausgeben) der aktuellen Liste
    return tasks;
  }

  @override
// Anzahlfunktion um gesamtzahl zu ermitteln
  Future<int> get itemCount async {
    // Zugriff auf SharedPref-Instanz
    final prefs = await SharedPreferences.getInstance();
// Auslesen der bestehenden Liste
    final tasks = prefs.getStringList(_key) ?? [];
// Alle inhalte der Liste werden zurückgegeben
    return tasks.length;
  }
}
