import 'package:flutter/material.dart';
import 'package:workshops_booking/services/database_service.dart';
import 'package:workshops_booking/models/bookings.dart';

class ViewBookings extends StatefulWidget {
  const ViewBookings({super.key});

  @override
  State<ViewBookings> createState() => _ViewBookingsState();
}

class _ViewBookingsState extends State<ViewBookings> {
  final DatabaseService _dbService = DatabaseService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Bookings"),
      ),
      body: FutureBuilder(
        future: _dbService.getBookings(), // Call the method to get bookings
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No bookings found"));
          }

          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              Bookings booking = snapshot.data![index];

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
                            const Text("Booking ID: "),
                            Text(booking.bid!),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Session ID: "),
                            Text(booking.sessionId!),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("User ID: "),
                            Text(booking.userId!),
                          ],
                        ),
                      ],
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     setState(
                    //       () {
                    //         _dbService.deleteBooking(booking.bid!);
                    //       },
                    //     );
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
