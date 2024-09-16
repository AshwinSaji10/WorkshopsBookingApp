import 'package:flutter/material.dart';

class AdminTile extends StatelessWidget {
  final String? displayText;
  final VoidCallback? onTap;
  const AdminTile({super.key, this.displayText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 70,
          width: 150,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10)),
          child: Center(child: Text(displayText!))),
    );
  }
}
