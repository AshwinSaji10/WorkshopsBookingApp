import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:workshops_booking/widgets/form_container_widget.dart';
import 'package:workshops_booking/services/database_service.dart';
// import 'package:uuid/uuid.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final TextEditingController _uidController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final DatabaseService _dbService = DatabaseService.instance;

  @override
  void dispose() {
    _uidController.dispose();
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
                hintText: "university registration number",
                controller: _uidController,
                isPasswordField: false,
              ),
              const SizedBox(
                height: 10,
              ),
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
                onPressed: () async {
                  if (_uidController.text.isEmpty ||
                      _usernameController.text.isEmpty ||
                      _passwordController.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: "Empty fields",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else {
                    try {
                      // var uuid = const Uuid();
                      // String uid = uuid.v4();
                      await _dbService.addUser(_uidController.text,
                          _usernameController.text, _passwordController.text);
                      Fluttertoast.showToast(
                        msg: "Successfully registered",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg: "Database Error",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  }
                },
                child: const Text("Register"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
