import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';
import 'package:simple_beautiful_checklist_exercise/shared/preferences.dart';

import 'features/splash/splash_screen.dart';
import 'home_screen.dart';

void main() async {
  // Wird benötigt, um auf SharedPreferences zuzugreifen
  WidgetsFlutterBinding.ensureInitialized();
  //WidgetsBindingObserver.didChangePlatformBrightness(); möglicher hinweis auf bug lösung?

  // TODO: Hier statt MockDatabase() ein SharedPreferencesRepository() verwenden.
  final prefs = await SharedPreferences
      .getInstance(); //Zugriff auf PrefRepo und ein objekt erstellt zum füllen
  final DatabaseRepository repository =
      SharedPreferencesRepository(prefs); // PrefRepo in Database implementiert

  runApp(MainApp(repository: repository));
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.repository,
  });

  final DatabaseRepository
      repository; // Als DataBase aufgerufen mit implemtierten daten

  //final DatabaseRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
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
      title: 'Checklisten App',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => HomeScreen(
              repository: repository, // Attacke!
            ),
      },
    );
  }
}
