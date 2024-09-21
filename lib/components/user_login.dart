import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:workshops_booking/widgets/form_container_widget.dart';
import 'package:workshops_booking/pages/user/user_landing.dart';
import 'package:workshops_booking/services/database_service.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final TextEditingController _uidController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final DatabaseService _dbService = DatabaseService.instance;

  @override
  void dispose() {
    _uidController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          const Text("User Login"),
          FormContainerWidget(
            hintText: "university registration number",
            controller: _uidController,
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
            onPressed: () async {
              if (_uidController.text == '' || _passwordController.text == '') {
                Fluttertoast.showToast(
                  msg: "Empty fields",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              } else {
                int loginResult = await _dbService.userLogin(
                    _uidController.text, _passwordController.text);
                if (loginResult == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserLanding(),
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
              }
            },
            child: const Text("Login"),
          )
        ],
      ),
    );
  }
}
