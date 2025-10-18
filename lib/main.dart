import 'package:digifarm/auth/widgets/auth_gate.dart';

import 'package:digifarm/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart'; 
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  await Firebase.initializeApp(
    options:  DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDateFormatting('id', null); 
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digifarm',
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
      home: const AuthGate(),
    );
  }
}
