import 'package:do_it/data/db_models.dart';
import 'package:do_it/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import 'presentation/screens/home_page.dart';

late Realm realm;

void main() {
  realm = Realm(Configuration.local([Task.schema]));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3556AB),
          background: bgColor,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
