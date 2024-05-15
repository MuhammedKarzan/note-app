import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/dark%20mode/theme_provider.dart';
import 'package:recipe/pages/insert.dart';
import 'package:recipe/pages/information/information.dart';
import 'package:recipe/pages/home.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child:const MyApp()));
}

// ignore: camel_case_types
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

// ignore: camel_case_types
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home':(context) => const home(),
        'insert':(context) => const insert(),
        'inf':(context) => const information(),
      },
  );
  }
}