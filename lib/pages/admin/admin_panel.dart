import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:workshops_booking/widgets/admin_tile.dart';
import 'package:workshops_booking/widgets/admin_view_button.dart';

import 'package:workshops_booking/pages/admin/add_items/add_new_instructor.dart';
import 'package:workshops_booking/pages/admin/add_items/add_new_location.dart';
import 'package:workshops_booking/pages/admin/add_items/add_new_session.dart';
import 'package:workshops_booking/pages/admin/add_items/add_new_workshop.dart';

import 'package:workshops_booking/pages/admin/display_items/view_workshops.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Admin Panel"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(66, 68, 137, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add Data",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AdminTile(
                        displayText: "Add new Workshop",
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const AddNewWorkshop(),
                            ),
                          );
                        },
                      ),
                      AdminTile(
                        displayText: "Add new location",
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const AddNewLocation(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AdminTile(
                        displayText: "Add new instructor",
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const AddNewInstructor(),
                            ),
                          );
                        },
                      ),
                      AdminTile(
                        displayText: "Add new session",
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const AddNewSession(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            // const Divider(
            //   height: 20,
            //   thickness: 1,
            //   endIndent: 0,
            //   color: Colors.black,
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(66, 68, 137, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "View Tables",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  AdminViewButton(
                    displayText: "View all workshops",
                    action: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const ViewWorkshops(),
                        ),
                      );
                    },
                  ),
                  AdminViewButton(
                    displayText: "View all locations",
                    action: () {},
                  ),
                  AdminViewButton(
                    displayText: "View all instructors",
                    action: () {},
                  ),
                  AdminViewButton(
                    displayText: "View all sessions",
                    action: () {},
                  ),
                  const SizedBox(height:20)
                  // OutlinedButton(onPressed: (){}, child: const Text("View all Workshops"))
                ],
              ),
            ),
            // const Divider(
            //   height: 20,
            //   thickness: 1,
            //   endIndent: 0,
            //   color: Colors.black,
            // ),
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(66, 68, 137, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const SizedBox(height:10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User Data",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  AdminViewButton(
                    displayText: "View all users",
                    action: () {},
                  ),
                  AdminViewButton(
                    displayText: "View all transactions",
                    action: () {},
                  ),
                  const SizedBox(height:20)
                ],
              ),
            ),
            const SizedBox(height:20)
          ],
        ),
      ),
    );
  }
}
