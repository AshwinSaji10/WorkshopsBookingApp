import 'package:flutter/material.dart';
import 'package:workshops_booking/components/user_login.dart';
import 'package:workshops_booking/components/admin_login.dart';

import 'package:workshops_booking/pages/user/register_user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int index = 0;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            index == 0 ? const Text("User Login") : const Text("Admin Login"),
            centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              index == 0
                  ? Column(
                      children: [
                        UserLogin(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterUser(),
                              ),
                            );
                          },
                          child: const Text("Register user"),
                        ),
                      ],
                    )
                  : const AdminLogin(),
              index == 0
                  ? TextButton(
                      onPressed: () {
                        setState(
                          () {
                            index = 1;
                          },
                        );
                      },
                      child: const Text("switch to Admin Login"),
                    )
                  : TextButton(
                      onPressed: () {
                        setState(
                          () {
                            index = 0;
                          },
                        );
                      },
                      child: const Text("switch to User Login"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
