import 'package:flutter/material.dart';
import 'Pages/home_page.dart';

Future<void> main() async {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white), // For normal text
        bodyMedium: TextStyle(color: Colors.white), // For normal text
        bodySmall: TextStyle(color: Colors.white), // For secondary text
      ),
    ),
    initialRoute: HomePage.routeName,
    routes: {
      HomePage.routeName: (context) => const HomePage(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
