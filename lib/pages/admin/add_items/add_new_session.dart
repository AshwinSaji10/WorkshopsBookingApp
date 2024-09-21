import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:workshops_booking/services/database_service.dart';
import 'package:workshops_booking/widgets/form_container_widget.dart';

class AddNewSession extends StatefulWidget {
  const AddNewSession({super.key});

  @override
  State<AddNewSession> createState() => _AddNewSessionState();
}

class _AddNewSessionState extends State<AddNewSession> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _workshopIdController = TextEditingController();
  final TextEditingController _locationIdController = TextEditingController();
  final TextEditingController _instructorIdController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  final DatabaseService _dbService = DatabaseService.instance;

  @override
  void dispose() {
    _idController.dispose();
    _workshopIdController.dispose();
    _locationIdController.dispose();
    _instructorIdController.dispose();
    _dateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Session"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            FormContainerWidget(
              hintText: "Session ID",
              controller: _idController,
              isPasswordField: false,
            ),
            const SizedBox(height: 20),
            FormContainerWidget(
              hintText: "Workshop ID",
              controller: _workshopIdController,
              isPasswordField: false,
            ),
            const SizedBox(height: 20),
            FormContainerWidget(
              hintText: "Location ID",
              controller: _locationIdController,
              isPasswordField: false,
            ),
            const SizedBox(height: 20),
            FormContainerWidget(
              hintText: "Instructor ID",
              controller: _instructorIdController,
              isPasswordField: false,
            ),
            const SizedBox(height: 20),
            FormContainerWidget(
              hintText: "Date",
              controller: _dateController,
              isPasswordField: false,
              inputType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            FormContainerWidget(
              hintText: "Start Time",
              controller: _startTimeController,
              isPasswordField: false,
              inputType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            FormContainerWidget(
              hintText: "End Time",
              controller: _endTimeController,
              isPasswordField: false,
              inputType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_idController.text.isEmpty ||
                    _workshopIdController.text.isEmpty ||
                    _locationIdController.text.isEmpty ||
                    _instructorIdController.text.isEmpty ||
                    _dateController.text.isEmpty ||
                    _startTimeController.text.isEmpty ||
                    _endTimeController.text.isEmpty) {
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
                    await _dbService.addSession(
                      _idController.text,
                      _workshopIdController.text,
                      _locationIdController.text,
                      _instructorIdController.text,
                      _dateController.text,
                      _startTimeController.text,
                      _endTimeController.text,
                    );

                    Fluttertoast.showToast(
                      msg: "Session added",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );

                    setState(() {
                      _idController.clear();
                      _workshopIdController.clear();
                      _locationIdController.clear();
                      _instructorIdController.clear();
                      _dateController.clear();
                      _startTimeController.clear();
                      _endTimeController.clear();
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
              child: const Text("Add Session"),
            )
          ],
        ),
      ),
    );
  }
}
