import 'package:flutter/material.dart';
import 'package:workshops_booking/widgets/form_container_widget.dart';

class AddNewWorkshop extends StatefulWidget {
  const AddNewWorkshop({super.key});

  @override
  State<AddNewWorkshop> createState() => _AddNewWorkshopState();
}

class _AddNewWorkshopState extends State<AddNewWorkshop> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _subjectController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Workshop"),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FormContainerWidget(
            hintText: "Workshop name",
            controller: _nameController,
            isPasswordField: false,
          ),
          const SizedBox(
            height: 20,
          ),
          FormContainerWidget(
            hintText: "Workshop subject",
            controller: _nameController,
            isPasswordField: false,
          ),
          const SizedBox(
            height: 20,
          ),
          FormContainerWidget(
            hintText: "Workshop duration",
            controller: _nameController,
            isPasswordField: false,
          ),
          ElevatedButton(onPressed: (){}, child: const Text("Add"))
        ],
      ),
    );
  }
}
