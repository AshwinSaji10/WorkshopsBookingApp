import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workshops_booking/models/workshops.dart';
import 'package:workshops_booking/services/database_service.dart';

class ViewWorkshops extends StatefulWidget {
  const ViewWorkshops({super.key});

  @override
  State<ViewWorkshops> createState() => _ViewWorkshopsState();
}

class _ViewWorkshopsState extends State<ViewWorkshops> {
  final DatabaseService _dbService = DatabaseService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Workshops"),
      ),
      body: FutureBuilder(
        future: _dbService.getWorkshops(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              Workshops workshop = snapshot.data![index];
              // return ListTile(
              //   title: Text(workshop.wname!),
              // );
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                            const Text("id:"),
                            Text(workshop.wid!),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("name:"),
                            Text(workshop.wname!),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("subject:"),
                            Text(workshop.wsubject!),
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
                                _dbService.deleteWorkshops(workshop.wid!);
                              },
                            );
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.edit))
                      ],
                    )

                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [

                    //   ],
                    // )
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
