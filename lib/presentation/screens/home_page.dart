import 'dart:async';

import 'package:do_it/data/db_models.dart';
import 'package:do_it/main.dart';
import 'package:do_it/presentation/screens/task_page.dart';
import 'package:do_it/presentation/theme/colors.dart';
import 'package:do_it/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:realm/realm.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final tasks = realm.all<Task>();
  late StreamSubscription<RealmResultsChanges<Task>> subscription;

  void gotoTaskPage(BuildContext context, {Task? task}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TaskPage(task: task),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    subscription = tasks.changes.listen((event) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(32, 19, 32, 46),
              color: color1,
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  Gap(21),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, Abdul-Mateen",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                            color: Colors.white,
                            shadows: [
                              Shadow(color: Colors.black, offset: Offset(0, 3))
                            ],
                          ),
                        ),
                        Gap(8),
                        Text("saeedabdulmateen0369@gmail.com",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w100,
                                shadows: [
                                  Shadow(
                                      color: Colors.black, offset: Offset(0, 3))
                                ])),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: goProBg,
                    // boxShadow: [
                    //   BoxShadow(color: Colors.white, spreadRadius: 40)
                    // ],
                    border: Border.all(color: goProBorder, width: 2),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 2,
                        color: Colors.white.withOpacity(0.6),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 32, 105, 32),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset("assets/images/ic_trophy.png"),
                            Gap(27),
                            const Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Go Pro (No Ads)",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: deepBlue,
                                        shadows: [
                                          Shadow(
                                              color: Colors.white,
                                              offset: Offset(0, 1))
                                        ]),
                                  ),
                                  Gap(6),
                                  Text("No fuss, no ads, for only \$1 a month",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF0D2972),
                                          shadows: [
                                            Shadow(
                                                color: Colors.white,
                                                offset: Offset(0, 1))
                                          ]))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 23,
                  child: Container(
                    color: deepBlue,
                    width: 66,
                    height: 71,
                    child: const Center(
                      child: Text(
                        "\$1",
                        style: TextStyle(
                            color: orange,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                itemCount: tasks.length,
                itemBuilder: (context, index) => TaskListItem(
                  task: tasks[index],
                  gotoTaskPage: (task) => gotoTaskPage(context, task: task),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => gotoTaskPage(context),
          tooltip: 'Increment',
          shape: const CircleBorder(side: BorderSide(color: color1, width: 2)),
          backgroundColor: fabBgColor,
          child: const Icon(
            Icons.add,
            size: 42,
            color: Colors.white,
            shadows: [],
          ),
        ),
      ),
    );
  }
}

class TaskListItem extends StatelessWidget {
  const TaskListItem(
      {super.key, required this.task, required this.gotoTaskPage});
  final Task task;
  final Function(Task task) gotoTaskPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 4),
              blurRadius: 4,
            )
          ]),
      padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 19),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: () => realm.write(
          () => realm.add(
            Task(task.id, task.taskName, !task.complete, task.createdOn),
            update: true,
          ),
        ),
        child: Row(
          children: [
            task.complete
                ? Image.asset(
                    "assets/icons/ic_checked_circle.png",
                    height: 32,
                    width: 32,
                  )
                : const Icon(
                    Icons.radio_button_off,
                    size: 32,
                    color: deepBlue,
                  ),
            const Gap(17),
            Expanded(
              flex: 1,
              child: Text(
                task.taskName,
                style: task.complete
                    ? TextStyle(
                        color: Colors.grey.shade600,
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      )
                    : const TextStyle(
                        color: deepBlue,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
              ),
            ),
            const Gap(16),
            OutlinedButton(
              onPressed: () => gotoTaskPage(task),
              style: ButtonStyle(
                foregroundColor: const MaterialStatePropertyAll(deepBlue),
                textStyle: const MaterialStatePropertyAll(
                  TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                      side: const BorderSide(color: deepBlue),
                      borderRadius: BorderRadius.circular(4)),
                ),
              ),
              child: const Text("Edit"),
            ),
          ],
        ),
      ),
    );
  }
}
