import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:workshops_booking/services/database_service.dart';
import 'package:workshops_booking/widgets/form_container_widget.dart';

class AddNewInstructor extends StatefulWidget {
  const AddNewInstructor({super.key});

  @override
  State<AddNewInstructor> createState() => _AddNewInstructorState();
}

class _AddNewInstructorState extends State<AddNewInstructor> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  final DatabaseService _dbService = DatabaseService.instance;

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _genderController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Instructor"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            FormContainerWidget(
              hintText: "Instructor ID",
              controller: _idController,
              isPasswordField: false,
            ),
            const SizedBox(height: 20),
            FormContainerWidget(
              hintText: "Instructor Name",
              controller: _nameController,
              isPasswordField: false,
            ),
            const SizedBox(height: 20),
            FormContainerWidget(
              hintText: "Gender",
              controller: _genderController,
              isPasswordField: false,
            ),
            const SizedBox(height: 20),
            FormContainerWidget(
              hintText: "Age",
              controller: _ageController,
              inputType: TextInputType.number,
              isPasswordField: false,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_idController.text.isEmpty ||
                    _nameController.text.isEmpty ||
                    _genderController.text.isEmpty ||
                    _ageController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "Empty fields",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else {
                  try {
                    _dbService.addInstructor(
                      _idController.text,
                      _nameController.text,
                      _genderController.text,
                      int.parse(_ageController.text),
                    );
                    Fluttertoast.showToast(
                      msg: "Instructor added",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );

                    setState(() {
                      _idController.clear();
                      _nameController.clear();
                      _genderController.clear();
                      _ageController.clear();
                    });
                  } catch (e) {
                    Fluttertoast.showToast(
                      msg: "Database error: ${e.toString()}",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                }
              },
              child: const Text("Add"),
            )
          ],
        ),
      ),
    );
  }
}
