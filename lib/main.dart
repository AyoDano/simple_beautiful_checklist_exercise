import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';
import 'package:simple_beautiful_checklist_exercise/shared/mock_database.dart';

import 'features/splash/splash_screen.dart';
import 'home_screen.dart';

void main() async {
  // Wird benötigt, um auf SharedPreferences zuzugreifen
  WidgetsFlutterBinding.ensureInitialized();

// Hinzugefügt SharedPferenceRepository
  final DatabaseRepository repository = SharedPreferencesRepository();

  runApp(MainApp(repository: repository));
}

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
  //
  Future<List<String>> getItems() {
    // TODO: implement getItems
    throw UnimplementedError();
  }

  @override
  // TODO: implement itemCount
  Future<int> get itemCount => throw UnimplementedError();
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.repository,
  });

  final DatabaseRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: GoogleFonts.robotoMonoTextTheme(Theme.of(context).textTheme),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.robotoMonoTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
      ),
      themeMode: ThemeMode.system,
      title: 'Checklisten App',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => HomeScreen(
              repository: repository,
            ),
      },
    );
  }
}
