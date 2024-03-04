import 'package:flutter/material.dart';
import 'package:my_family/database/family_database.dart';
import 'package:my_family/pages/home.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FamilyDatabase.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (context) => FamilyDatabase(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Rubik"),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
