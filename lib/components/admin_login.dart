import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:workshops_booking/widgets/form_container_widget.dart';
import 'package:workshops_booking/pages/admin/admin_panel.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          FormContainerWidget(
            hintText: "username",
            controller: _usernameController,
            isPasswordField: false,
          ),
          const SizedBox(
            height: 10,
          ),
          FormContainerWidget(
            hintText: "password",
            controller: _passwordController,
            isPasswordField: true,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              if (_usernameController.text == "admin" &&
                  _passwordController.text == "1234") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminPanel(),
                  ),
                );
              } else {
                Fluttertoast.showToast(
                    msg: "Invalid details",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
              }
            },
            child: const Text("Login"),
          )
        ],
      ),
    );
  }
}
