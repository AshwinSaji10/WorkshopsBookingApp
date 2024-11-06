import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:workshops_booking/services/database_service.dart';
import 'package:workshops_booking/widgets/form_container_widget.dart';

import 'package:intl/intl.dart';

final formatter = DateFormat("yyyy-MM-dd");
final timeFormatter = DateFormat("hh:mm a");

class AddNewSession extends StatefulWidget {
  const AddNewSession({super.key});

  @override
  State<AddNewSession> createState() => _AddNewSessionState();
}

class _AddNewSessionState extends State<AddNewSession> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _workshopIdController = TextEditingController();
  final TextEditingController _locationIdController = TextEditingController();
  final TextEditingController _instructorIdController = TextEditingController();
  // final TextEditingController _dateController = TextEditingController();
  // final TextEditingController _startTimeController = TextEditingController();
  // final TextEditingController _endTimeController = TextEditingController();

  final DatabaseService _dbService = DatabaseService.instance;

  @override
  void dispose() {
    _idController.dispose();
    _workshopIdController.dispose();
    _locationIdController.dispose();
    _instructorIdController.dispose();
    // _dateController.dispose();
    // _startTimeController.dispose();
    // _endTimeController.dispose();
    super.dispose();
  }

  Future<void> datePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year, now.month + 2, now.day),
    );
    if (pickedDate != null) {
      setState(
        () {
          _selectedDate = pickedDate;
        },
      );
    }
  }

  Future<void> timePicker(String label) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(
        () {
          if (label == "Start") {
            _selectedStartTime = pickedTime;
          } else {
            _selectedEndTime = pickedTime;
          }
        },
      );
    }
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return timeFormatter.format(dateTime); // Formats to "hh:mm a"
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Session"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
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
              // FormContainerWidget(
              //   hintText: "Date",
              //   controller: _dateController,
              //   isPasswordField: false,
              //   inputType: TextInputType.datetime,
              // ),
              GestureDetector(
                onTap: () => datePicker(),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          _selectedDate == null
                              ? "Select Workshop date"
                              : formatter.format(_selectedDate!),
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.calendar_month),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // FormContainerWidget(
              //   hintText: "Start Time",
              //   controller: _startTimeController,
              //   isPasswordField: false,
              //   inputType: TextInputType.datetime,
              // ),
              GestureDetector(
                onTap: () => timePicker("Start"),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          _selectedStartTime == null
                              ? "Select Start Time"
                              : _selectedStartTime!.format(context),
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.access_time),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // FormContainerWidget(
              //   hintText: "End Time",
              //   controller: _endTimeController,
              //   isPasswordField: false,
              //   inputType: TextInputType.datetime,
              // ),
              GestureDetector(
                onTap: () => timePicker("End"),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          _selectedEndTime == null
                              ? "Select End Time"
                              : _selectedEndTime!.format(context),
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.access_time),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_idController.text.isEmpty ||
                      _workshopIdController.text.isEmpty ||
                      _locationIdController.text.isEmpty ||
                      _instructorIdController.text.isEmpty ||
                      _selectedDate == null ||
                      _selectedStartTime == null ||
                      _selectedEndTime == null) {
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
                        formatter.format(_selectedDate!),
                        formatTimeOfDay(_selectedStartTime!),
                        formatTimeOfDay(_selectedEndTime!),
                      );

                      Fluttertoast.showToast(
                        msg: "Session added",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );

                      setState(
                        () {
                          _idController.clear();
                          _workshopIdController.clear();
                          _locationIdController.clear();
                          _instructorIdController.clear();
                          _selectedDate = null;
                          _selectedStartTime = null;
                          _selectedEndTime = null;
                        },
                      );
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg:
                            "Database error: ${e.toString()}",
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
      ),
    );
  }
}
