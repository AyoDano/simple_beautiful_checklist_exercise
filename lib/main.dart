import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
