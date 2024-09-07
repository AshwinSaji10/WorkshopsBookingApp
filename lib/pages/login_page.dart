import 'package:flutter/material.dart';
import 'package:workshops_booking/components/user_login.dart';
import 'package:workshops_booking/components/admin_login.dart';

import 'package:workshops_booking/pages/register_user.dart';

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
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 50),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        Container(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                index = 1;
                              });
                            },
                            child: const Text("switch to Admin Login"),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        AdminLogin(),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              index = 0;
                            });
                          },
                          child: const Text("switch to User Login"),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
