import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe/database/recipe.dart';
import 'package:recipe/database/recipeDb.dart';

// ignore: camel_case_types
class insert extends StatefulWidget {
  const insert({super.key});

  @override
  State<insert> createState() => _insertState();
}

// ignore: camel_case_types
class _insertState extends State<insert> {
  String selectedImagePath = '';
  String error = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController requirementsController = TextEditingController();
  TextEditingController timeAttController = TextEditingController();
  TextEditingController informationController = TextEditingController();
  String buttonName = 'ADD';
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    if (arguments['id'] != '') {
      nameController.text = arguments['name'];
      requirementsController.text = arguments['requirements'];
      timeAttController.text = arguments['timeAtt'];
      informationController.text = arguments['information'];
      selectedImagePath = arguments['photo'];
      buttonName = 'Update';
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe"),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 15, 12, 15),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.all(Radius.circular(60))),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: "Name of The Food",
                                hintStyle: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: requirementsController,
                              decoration: InputDecoration(
                                hintText: "requirements",
                                hintStyle: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: timeAttController,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            hintText: "Time required for preparation",
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: informationController,
                          decoration: InputDecoration(
                            hintText: "Additional information",
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                            onPressed: () async {
                              selectImage();
                              setState(() {});
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 10, 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                              ))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: 40,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  Text(
                                    "Select image",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      Text(
                        error,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 248, 2, 2),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      MaterialButton(
                        onPressed: () {
                          if (selectedImagePath == '' ||
                              nameController.text.isEmpty ||
                              requirementsController.text.isEmpty ||
                              timeAttController.text.isEmpty ||
                              informationController.text.isEmpty) {
                            setState(() {
                              error = 'Check fields........';
                            });
                          } else {
                            if (arguments['id'] != '') {
                              updateBook() async {
                                final recipe = Recipe(
                                    id: arguments['id'],
                                    name: nameController.text,
                                    requirements: requirementsController.text,
                                    photo: selectedImagePath,
                                    timeAtt: timeAttController.text,
                                    information: informationController.text,
                                    time: arguments['time']);

                                RecipeDb.update(recipe: recipe);
                                Navigator.pushNamed(context, 'home');
                              }

                              updateBook();
                            } else {
                              insertB() async {
                                final recipe = Recipe(
                                    name: nameController.text,
                                    requirements: requirementsController.text,
                                    photo: selectedImagePath,
                                    timeAtt: timeAttController.text,
                                    information: informationController.text,
                                    time: DateTime.now());
                                RecipeDb.insert(recipe: recipe);
                                Navigator.pushNamed(context, 'home');
                              }

                              insertB();
                            }
                          }
                        },
                        height: 50,
                        // margin: EdgeInsets.symmetric(horizontal: 50),
                        color: Theme.of(context).colorScheme.background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        // decoration: BoxDecoration(
                        // ),
                        child: Center(
                          child: Text(
                            buttonName,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              height: 170,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 11, 0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          setState(() async {
                            selectedImagePath = await selectImageFromGallery();
                          });

                          if (kDebugMode) {
                            print('Image_Path:-');
                          }
                          if (kDebugMode) {
                            print(selectedImagePath);
                          }
                          if (selectedImagePath != '') {
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            setState(() {});
                          } else {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("No Image Selected !"),
                            ));
                          }
                        },
                        child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: SizedBox(
                                    width: 120,
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/gallery.png',
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          height: 74,
                                          width: 80,
                                        ),
                                        const Text('Gallery'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() async {
                            selectedImagePath = await selectImageFromGallery();
                          });
                          if (kDebugMode) {
                            print('Image_Path:-');
                          }
                          if (kDebugMode) {
                            print(selectedImagePath);
                          }

                          if (selectedImagePath != '') {
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            setState(() {});
                          } else {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("No Image Captured !"),
                            ));
                          }
                        },
                        child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 1.0),
                                  child: SizedBox(
                                    width: 120,
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/camera.png',
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          height: 80,
                                          width: 80,
                                        ),
                                        const Text('Camera'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  //
  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }
}
