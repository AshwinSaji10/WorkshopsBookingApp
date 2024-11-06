import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:workshops_booking/services/database_service.dart';
import 'package:workshops_booking/widgets/form_container_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AddNewInstructor extends StatefulWidget {
  const AddNewInstructor({super.key});

  @override
  State<AddNewInstructor> createState() => _AddNewInstructorState();
}

class _AddNewInstructorState extends State<AddNewInstructor> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _genderController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  final DatabaseService _dbService = DatabaseService.instance;

  final List<String> gender = ['Male', 'Female', 'Other'];
  String? selectedGender;

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    // _genderController.dispose();
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
            // FormContainerWidget(
            //   hintText: "Gender",
            //   controller: _genderController,
            //   isPasswordField: false,
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: const Row(
                  children: [
                    Icon(
                      Icons.list,
                      size: 16,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text(
                        'Select Gender',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: gender
                    .map(
                      (String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                value: selectedGender,
                onChanged: (value) {
                  setState(
                    () {
                      selectedGender = value;
                    },
                  );
                },
                buttonStyleData: ButtonStyleData(
                  height: 60,
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                    // color: Colors.redAccent,
                  ),
                  elevation: 0,
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                  iconSize: 14,
                  iconEnabledColor: Colors.black,
                  iconDisabledColor: Colors.grey,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                  ),
                  offset: const Offset(0, 0),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: WidgetStateProperty.all(6),
                    thumbVisibility: WidgetStateProperty.all(true),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.only(left: 14, right: 14),
                ),
              ),
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
              onPressed: () async {
                if (_idController.text.isEmpty ||
                    _nameController.text.isEmpty ||
                    selectedGender == null ||
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
                    await _dbService.addInstructor(
                      _idController.text,
                      _nameController.text,
                      selectedGender!,
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
                      selectedGender = null;
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
