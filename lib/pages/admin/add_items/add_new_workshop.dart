import 'package:flutter/material.dart';
import 'package:workshops_booking/services/database_service.dart';
import 'package:workshops_booking/widgets/form_container_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AddNewWorkshop extends StatefulWidget {
  const AddNewWorkshop({super.key});

  @override
  State<AddNewWorkshop> createState() => _AddNewWorkshopState();
}

class _AddNewWorkshopState extends State<AddNewWorkshop> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _subjectController = TextEditingController();

  final DatabaseService _dbService = DatabaseService.instance;

  final List<String> items = [
    'Computer Science',
    'Electronics and Communication',
    'Civil Engineering',
    'Mechanical Engineering',
    'Information Technology',
    'Zoology',
    'Botany',
    'Life Science'
  ];
  String? selectedValue;

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    // _subjectController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Workshop"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FormContainerWidget(
              hintText: "Workshop id",
              controller: _idController,
              isPasswordField: false,
            ),
            const SizedBox(
              height: 20,
            ),
            FormContainerWidget(
              hintText: "Workshop name",
              controller: _nameController,
              isPasswordField: false,
            ),
            const SizedBox(
              height: 20,
            ),
            // FormContainerWidget(
            //   hintText: "Workshop subject",
            //   controller: _subjectController,
            //   isPasswordField: false,
            // ),
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
                        'Select Workshop Subject',
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
                items: items
                    .map((String item) => DropdownMenuItem<String>(
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
                        ))
                    .toList(),
                value: selectedValue,
                onChanged: (value) {
                  setState(
                    () {
                      selectedValue = value;
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

            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_idController.text == '' ||
                    _nameController.text == '' ||
                    selectedValue == null) {
                  Fluttertoast.showToast(
                    msg: "Empty fields",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else {
                  try {
                    // Await the asynchronous addWorkshops function
                    await _dbService.addWorkshops(
                      _idController.text,
                      _nameController.text,
                      selectedValue!,
                    );

                    Fluttertoast.showToast(
                      msg: "Workshop added",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );

                    setState(
                      () {
                        _idController.clear();
                        _nameController.clear();
                        selectedValue = null;
                      },
                    );
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
