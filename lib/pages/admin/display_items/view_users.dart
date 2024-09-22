import 'package:flutter/material.dart';
import 'package:workshops_booking/services/database_service.dart';
import 'package:workshops_booking/models/users.dart';

class ViewUsers extends StatefulWidget {
  const ViewUsers({super.key});

  @override
  State<ViewUsers> createState() => _ViewUsersState();
}

class _ViewUsersState extends State<ViewUsers> {
  final DatabaseService _dbService = DatabaseService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Users"),
      ),
      body: FutureBuilder(
        future: _dbService.getUsers(), // Call the method to get users
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No users found"));
          }

          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              Users user = snapshot.data![index];

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text("ID: "),
                            Text(user.uid!),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Name: "),
                            Text(user.uname!),
                          ],
                        ),
                      ],
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     setState(() {
                    //       _dbService.deleteUser(user.uid!);
                    //     });
                    //   },
                    //   icon: const Icon(Icons.delete),
                    // ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
