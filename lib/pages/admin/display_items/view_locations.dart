
import 'package:flutter/material.dart';
import 'package:workshops_booking/services/database_service.dart';
import 'package:workshops_booking/models/locations.dart';

class ViewLocations extends StatefulWidget {
  const ViewLocations({super.key});

  @override
  State<ViewLocations> createState() => _ViewLocationsState();
}

class _ViewLocationsState extends State<ViewLocations> {

  final DatabaseService _dbService = DatabaseService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Locations"),
      ),
      body: FutureBuilder(
        future: _dbService.getLocations(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              Locations location = snapshot.data![index];
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
                            Text(location.lid!),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("name:"),
                            Text(location.lname!),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("capacity:"),
                            Text(location.capacity.toString()),
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
                                _dbService.deleteLocation(location.lid!);
                              },
                            );
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        // IconButton(
                        //     onPressed: () {}, icon: const Icon(Icons.edit))
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