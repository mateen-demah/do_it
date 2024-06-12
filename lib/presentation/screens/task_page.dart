import 'package:do_it/data/db_models.dart';
import 'package:do_it/main.dart';
import 'package:do_it/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

class TaskPage extends StatelessWidget {
  TaskPage({super.key, this.task})
      : nameController = TextEditingController(text: task?.taskName);
  final Task? task;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? "Add New Task" : "Edit Task"),
        centerTitle: true,
        backgroundColor: color1,
        titleTextStyle: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(color: Colors.black, offset: Offset(0, 3))]),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      // backgroundColor: Colors.whi,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(17, 39, 17, 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Task name is required";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 2),
                  ),
                  fillColor: const Color(0xFFFDFDFD),
                  filled: true,
                  labelText: "Task Name",
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                    textStyle: const MaterialStatePropertyAll(TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        shadows: [
                          Shadow(color: Colors.black, offset: Offset(0, 2))
                        ])),
                    backgroundColor: const MaterialStatePropertyAll(color1),
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 20)),
                    minimumSize:
                        const MaterialStatePropertyAll(Size.fromHeight(60)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: BorderSide(
                          width: 2,
                          color: Color(0xFF0D2972),
                        )))),
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    realm.write(() {
                      realm.add(
                        Task(ObjectId(), nameController.text.trim(), false,
                            DateTime.now()),
                      );
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: const Text("Done"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
