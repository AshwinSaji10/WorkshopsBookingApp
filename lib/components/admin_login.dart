import 'package:flutter/material.dart';
import 'package:workshops_booking/widgets/form_container_widget.dart';
import 'package:workshops_booking/pages/admin_panel.dart';

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
    return  Container(
      margin: const EdgeInsets.only(left: 10,right: 10),
      child: Column(
        children: [
          const Text("Admin Login"),
          FormContainerWidget(
            hintText: "username",
            controller: _usernameController,
            isPasswordField: false,
          ),
          const SizedBox(height: 10,),
          FormContainerWidget(
            hintText: "password",
            controller: _passwordController,
            isPasswordField: true,
          ),
          ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminPanel()));
                },
                child: const Text("Login"),
              )
        ],
      ),
    );
  }
}