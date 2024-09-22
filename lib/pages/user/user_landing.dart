import 'package:flutter/material.dart';
import 'package:workshops_booking/widgets/form_container_widget.dart';
import 'package:workshops_booking/services/database_service.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat("dd-MM-yyyy");

class UserLanding extends StatefulWidget {
  final String? uid;
  const UserLanding({super.key, this.uid});

  @override
  State<UserLanding> createState() => _UserLandingState();
}

class _UserLandingState extends State<UserLanding> {
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

  DateTime? _selectedDate;
  void datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime.now();
    final lastDate = DateTime(now.year, now.month + 2, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      // if (time == "start") {
      //   _selectedStartDate = pickedDate;
      // } else {
      _selectedDate = pickedDate;
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("uid:${widget.uid!}"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const Text("Search for Workshops"),
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
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Container(
                    //   margin: const EdgeInsets.only(left: 5),
                    //   child: Text(
                    //     "Select workshop date",
                    //     // style: theme.textTheme.bodyLarge,
                    //   ),
                    // ),
                  ],
                ),
                GestureDetector(
                  onTap: () => datePicker(),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // color: theme.colorScheme.tertiary,
                      border: Border.all(
                        color: Colors.black26, // Set your desired color here
                        width: 1, // Border width
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(_selectedDate == null
                              ? "Select Workshop date"
                              : formatter.format(_selectedDate!)),
                        ),
                        Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: const Icon(Icons.calendar_month))
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    
                  },
                  child: const Text("Search"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
