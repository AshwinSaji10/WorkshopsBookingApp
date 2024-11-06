import 'package:flutter/material.dart';
import 'package:workshops_booking/services/database_service.dart';
import 'package:workshops_booking/models/sessions.dart';

class ViewSessions extends StatefulWidget {
  const ViewSessions({super.key});

  @override
  State<ViewSessions> createState() => _ViewSessionsState();
}

class _ViewSessionsState extends State<ViewSessions> {
  final DatabaseService _dbService = DatabaseService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Sessions"),
      ),
      body: FutureBuilder(
        future: _dbService.getSessions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading sessions"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No sessions available"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Sessions session = snapshot.data![index];
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 160,
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
                              const Text("Session ID: "),
                              Text(session.sid!),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Workshop ID: "),
                              Text(session.wid!),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Location ID: "),
                              Text(session.lid!),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Instructor ID: "),
                              Text(session.iid!),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Date: "),
                              Text(session.date!),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Start Time: "),
                              Text(session.startTime!),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("End Time: "),
                              Text(session.endTime!),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _dbService.deleteSession(session.sid!);
                              });
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          // IconButton(
                          //   onPressed: () {
                          //     // You can implement the edit functionality here
                          //   },
                          //   icon: const Icon(Icons.edit),
                          // ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
