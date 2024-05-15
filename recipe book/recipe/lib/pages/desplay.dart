import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe/database/recipe.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:recipe/database/recipeDb.dart';

class desplay extends StatefulWidget {
  final Recipe recipe;
  const desplay({super.key, required this.recipe});

  @override
  State<desplay> createState() => _desplayState();
}

class _desplayState extends State<desplay> {
  @override
  Widget build(BuildContext context) {
    var name = widget.recipe.name;
    return RawMaterialButton(
      onPressed: () {
        Navigator.pushNamed(context, 'inf', arguments: {
          'name': widget.recipe.name,
          'requirements': widget.recipe.requirements,
          'photo': widget.recipe.photo,
          'timeAtt': widget.recipe.timeAtt,
          'time': widget.recipe.time,
          'information': widget.recipe.information,
        });
      },
      child: Slidable(
        key: const ValueKey(0),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: ((context) {
                deleted();
              }),
              backgroundColor: Color.fromARGB(255, 253, 2, 2),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: ((context) {
                Navigator.pushNamed(context, 'insert', arguments: {
                  'name': widget.recipe.name,
                  'id': widget.recipe.id,
                  'requirements': widget.recipe.requirements,
                  'timeAtt': widget.recipe.timeAtt,
                  'time': widget.recipe.time,
                  'information': widget.recipe.information,
                  'photo': widget.recipe.photo,
                });
              }),
              backgroundColor: Color.fromARGB(255, 231, 77, 5),
              foregroundColor: Colors.white,
              icon: Icons.update,
              label: 'Update',
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.file(
                File(widget.recipe.photo),
                height: 100,
                width: 90,
                fit: BoxFit.fill,
              ),
              Icon(Icons.restaurant),
              SizedBox(
                width: 150,
                height: 90,
                child: Center(
                  child: Text(
                    "Name Book: $name",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16),
                  ),
                ),
              ),
              Icon(Icons.restaurant),
            ],
          ),
        ),
      ),
    );
  }

  Future deleted() {
    var nameitem = widget.recipe.name;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.background,
              ),
              height: 130,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        'Are you sure delete $nameitem?',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 11, 0, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: delete,
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              )),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'No',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  delete() async {
    final recipe = Recipe(
      id: widget.recipe.id,
      name: widget.recipe.name,
      requirements: widget.recipe.requirements,
      photo: widget.recipe.photo,
      timeAtt: widget.recipe.timeAtt,
      time: widget.recipe.time,
      information: widget.recipe.information,
    );
    RecipeDb.delete(recipe: recipe);
    Navigator.pushNamed(context, 'home');
  }
}
