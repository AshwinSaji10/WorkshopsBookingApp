import 'package:flutter/material.dart';

class AdminViewButton extends StatefulWidget {
  final String? displayText;
  final VoidCallback? action;
  const AdminViewButton({super.key, this.displayText, this.action});

  @override
  State<AdminViewButton> createState() => _AdminViewButtonState();
}

class _AdminViewButtonState extends State<AdminViewButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.action,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Text(widget.displayText!)),
      ),
    );
  }
}
