import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live_weather_api_demo/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Forcer l'orientation du terminal
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather API',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 7, 4, 13)),
          scaffoldBackgroundColor: Colors.blue,
          useMaterial3: false,
        ),
        home: const HomePage());
  }
}
