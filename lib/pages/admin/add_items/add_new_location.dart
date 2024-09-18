import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:workshops_booking/services/database_service.dart';
import 'package:workshops_booking/widgets/form_container_widget.dart';

class AddNewLocation extends StatefulWidget {
  const AddNewLocation({super.key});

  @override
  State<AddNewLocation> createState() => _AddNewLocationState();
}

class _AddNewLocationState extends State<AddNewLocation> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();

  final DatabaseService _dbService = DatabaseService.instance;

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _capacityController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Location"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FormContainerWidget(
              hintText: "Location id",
              controller: _idController,
              isPasswordField: false,
            ),
            const SizedBox(
              height: 20,
            ),
            FormContainerWidget(
              hintText: "Location name",
              controller: _nameController,
              isPasswordField: false,
            ),
            const SizedBox(
              height: 20,
            ),
            FormContainerWidget(
              hintText: "Venue Capacity",
              controller: _capacityController,
              inputType: TextInputType.number,
              isPasswordField: false,
            ),

            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (_idController.text == '' ||
                    _nameController.text == '' ||
                    _capacityController.text == '') {
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
                    _dbService.addLocation(_idController.text,
                        _nameController.text, int.parse(_capacityController.text));
                    Fluttertoast.showToast(
                        msg: "Location added",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);

                    setState(() {
                      _idController.clear();
                      _nameController.clear();
                      _capacityController.clear();
                    });

                    // _subjectController.clear();
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
      ),
    );
  }
}