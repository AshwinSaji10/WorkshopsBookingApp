import 'package:flutter/material.dart';
import 'package:workshops_booking/widgets/form_container_widget.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  
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
      margin: const EdgeInsets.only(left: 10,right: 10),
      child: Column(
        children: [
          const Text("User Login"),
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
                onPressed: () {},
                child: const Text("Login"),
              )
        ],
      ),
    );
  }
}
