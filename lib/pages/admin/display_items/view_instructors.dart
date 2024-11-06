import 'package:flutter/material.dart';
import 'package:workshops_booking/services/database_service.dart';
import 'package:workshops_booking/models/instructors.dart';

class ViewInstructors extends StatefulWidget {
  const ViewInstructors({super.key});

  @override
  State<ViewInstructors> createState() => _ViewInstructorsState();
}

class _ViewInstructorsState extends State<ViewInstructors> {
  final DatabaseService _dbService = DatabaseService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Instructors"),
      ),
      body: FutureBuilder(
        future: _dbService.getInstructors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error fetching instructors"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No instructors available"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Instructors instructor = snapshot.data![index];

                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 100,
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
                              Text(instructor.iid!),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Name: "),
                              Text(instructor.iname!),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Gender: "),
                              Text(instructor.gender!),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Age: "),
                              Text(instructor.age.toString()),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(
                                () {
                                  _dbService.deleteInstructor(instructor.iid!);
                                },
                              );
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          // IconButton(
                          //   onPressed: () {
                          //     // Navigate to an edit page or handle edit logic
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
