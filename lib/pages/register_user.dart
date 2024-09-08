import 'package:flutter/material.dart';
import 'package:workshops_booking/widgets/form_container_widget.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
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
    return Scaffold(
      appBar: AppBar( 
        title: const Text("Register a new User"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              // TextFormField(),
              // TextFormField(),
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
              ElevatedButton(
                onPressed: () {},
                child: const Text("Register"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
