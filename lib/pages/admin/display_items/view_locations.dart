
import 'package:flutter/material.dart';
import 'package:workshops_booking/services/database_service.dart';

class ViewLocations extends StatefulWidget {
  const ViewLocations({super.key});

  @override
  State<ViewLocations> createState() => _ViewLocationsState();
}

class _ViewLocationsState extends State<ViewLocations> {

  final DatabaseService _dbService = DatabaseService.instance;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}