import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class information extends StatefulWidget {
  const information({super.key});

  @override
  State<information> createState() => _informationState();
}

// ignore: camel_case_types
class _informationState extends State<information> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    var name = arguments['name'];
    var requirment = arguments['requirements'];
    var timeAtt = arguments['timeAtt'];
    var information = arguments['information'];
    var time = arguments['time'];
    var photo = arguments['photo'];

    return Scaffold(
        appBar: AppBar(
          title: const Text("Recipe"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(12, 15, 12, 15),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.all(Radius.circular(60))),
            child: Stack(
              children: [
                ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: SizedBox(
                          height: 210,
                          width: 210,
                          child: Card(
                            color: Theme.of(context).colorScheme.background,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.file(
                                File(photo),
                                height: 200,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('Name of the food: $name',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('Requirment: $requirment',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('Time required for preparation: $timeAtt',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('Information: $information',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 30,
                  left: 60,
                  right: 55,
                  child: Text(
                      'Time Start: ${DateFormat(DateFormat.YEAR_NUM_MONTH_WEEKDAY_DAY).format(time)},${DateFormat(DateFormat.HOUR_MINUTE).format(time)}',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),)
              ],
            ),
          ),
        ));
  }
}
