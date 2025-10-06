import 'package:digifarm/auth/screen/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 60, 180, 179),
          ),
          titleMedium: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          bodyLarge: TextStyle(
            fontFamily: 'NunitoSans',
            height: 1.32,
            fontSize: 12,
            color: Color.fromARGB(215, 6, 4, 4),
          ),
          bodyMedium: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 12,
            color: Color.fromARGB(255,66, 72, 74),
          ),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
