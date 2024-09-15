import 'package:flutter/material.dart';
import 'package:workshops_booking/services/database_service.dart';
import 'package:workshops_booking/widgets/form_container_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddNewWorkshop extends StatefulWidget {
  const AddNewWorkshop({super.key});

  @override
  State<AddNewWorkshop> createState() => _AddNewWorkshopState();
}

class _AddNewWorkshopState extends State<AddNewWorkshop> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  final DatabaseService _dbService = DatabaseService.instance;

  @override
  void dispose() {
    _nameController.dispose();
    _subjectController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Workshop"),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FormContainerWidget(
            hintText: "Workshop id",
            controller: _idController,
            isPasswordField: false,
          ),
          FormContainerWidget(
            hintText: "Workshop name",
            controller: _nameController,
            isPasswordField: false,
          ),
          const SizedBox(
            height: 20,
          ),
          FormContainerWidget(
            hintText: "Workshop subject",
            controller: _subjectController,
            isPasswordField: false,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              if (_idController.text == '' ||
                  _nameController.text == '' ||
                  _subjectController.text == '') {
                Fluttertoast.showToast(
                    msg: "Empty fields",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                try {
                  _dbService.addWorkshops(_idController.text,
                      _nameController.text, _subjectController.text);
                  Fluttertoast.showToast(
                      msg: "Workshop added",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                      
                  _idController.clear();
                  _nameController.clear();
                  _subjectController.clear();
                } catch (e) {
                  Fluttertoast.showToast(
                    msg: "Database error: ${e.toString()}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
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
    );
  }
}
