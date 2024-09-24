import 'package:flutter/material.dart';
// import 'package:workshops_booking/widgets/form_container_widget.dart';
import 'package:workshops_booking/services/database_service.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';
import 'package:workshops_booking/models/search_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:uuid/uuid.dart';

final formatter = DateFormat("yyyy-MM-dd");

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
  List<SessionDetails> _searchResults = [];

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

  Future<void> performSearch() async {
    if (selectedValue != null && _selectedDate != null) {
      try {
        List<SessionDetails> results = await _dbService.searchSession(
          selectedValue!,
          formatter.format(_selectedDate!),
        );
        setState(
          () {
            _searchResults = results;
          },
        );
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User ID: ${widget.uid!}"),
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
                    SizedBox(width: 4),
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
                    border: Border.all(color: Colors.black26),
                  ),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(Icons.arrow_forward_ios_outlined),
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
                      child: Text(_selectedDate == null
                          ? "Select Workshop date"
                          : formatter.format(_selectedDate!)),
                    ),
                    const Icon(Icons.calendar_month),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: performSearch,
              child: const Text("Search"),
            ),
            const SizedBox(height: 20),
            _searchResults.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final session = _searchResults[index];

                        // Wrap the button part with FutureBuilder
                        return FutureBuilder<bool>(
                          future: _dbService.checkBookingExists(
                              session.sessionId,
                              widget.uid!), // Call the async function
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // Display a loading indicator while the check is in progress
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              // Handle errors gracefully
                              return const Center(
                                  child: Text("Error checking booking status"));
                            } else {
                              // Check the booking status
                              bool isBooked = snapshot.data ?? false;

                              // Render the session details and buttons based on the booking status
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                height:
                                    100, // Adjust height according to your needs
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            const Text("Id: "),
                                            Text(session.sessionId),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text("Name: "),
                                            Text(session.workshopName,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text("Instructor: "),
                                            Text(session.instructorName),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text("Time: "),
                                            Text(
                                                "${session.startTime} - ${session.endTime}"),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // Display different buttons based on booking status
                                    isBooked
                                        ? ElevatedButton(
                                            onPressed: () {
                                              // Action for an already booked session
                                              Fluttertoast.showToast(
                                                msg:
                                                    "You have already booked this session.",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.blue,
                                                textColor: Colors.white,
                                                fontSize: 16.0,
                                              );
                                            },
                                            child: const Text("Already Booked"),
                                          )
                                        : ElevatedButton(
                                            onPressed: () async {
                                            
                                              var uuid = const Uuid();
                                              String bookingId = uuid.v4();

                                              try {
                                                await _dbService.addBooking(
                                                    bookingId,
                                                    session.sessionId,
                                                    widget.uid!);
                                                // Show success toast
                                                Fluttertoast.showToast(
                                                  msg: "Booking successful!",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor: Colors.green,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0,
                                                );
                                              } catch (e) {
                                                // Show failure toast
                                                Fluttertoast.showToast(
                                                  msg:
                                                      "Booking failed: ${e.toString()}",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0,
                                                );
                                              }
                                            },
                                            child: const Text("Book"),
                                          ),
                                  ],
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  )
                : const Text("No results found"),
          ],
        ),
      ),
    );
  }
}
