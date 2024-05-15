import 'package:flutter/material.dart';
import 'package:recipe/dark%20mode/theme_provider.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class mydrawer extends StatelessWidget {
  const mydrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: ListTile(
            title: const Text("Mode"),
            onTap: Provider.of<ThemeProvider>(context, listen: false).toggleTheme,
            subtitle: const Text("used to light and dark mode"),
            leading: const Icon(Icons.dark_mode),
            isThreeLine: true,
            dense: true,
          ),
        ),
      ]),
    );
  }
}