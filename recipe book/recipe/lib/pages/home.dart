import 'package:flutter/material.dart';
import 'package:recipe/database/recipeDb.dart';
import 'package:recipe/menu/menu.dart';
import 'package:recipe/pages/desplay.dart';

// ignore: camel_case_types
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

// ignore: camel_case_types
class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const mydrawer(),
      appBar: AppBar(
        title: const Text("Recipe"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 15, 12, 15),
            child: Container(
              decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.all(Radius.circular(60))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    FutureBuilder(
                        future: RecipeDb.getRecipe(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.data == null) {
                              return const Center(
                                child: Text("Empty"),
                              );
                            }
                            return Column(
                              children: [
                                for (var recipe in snapshot.data!)
                                  desplay(recipe: recipe)
                              ],
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 30,
              right: 20,
              child: IconButton(
                icon: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.all(Radius.circular(60))),
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, 'insert', arguments: {'id': ''}),
              ))
        ],
      ),
    );
  }
}