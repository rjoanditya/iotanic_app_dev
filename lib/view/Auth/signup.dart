// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import 'package:iotanic_app_dev/main.dart';
import 'package:iotanic_app_dev/model/auth.dart';
import 'package:iotanic_app_dev/view/App/index.dart';
import 'package:iotanic_app_dev/view/Auth/signin.dart';
import 'package:provider/provider.dart';

import 'package:validators/validators.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:iotanic_app_dev/view/App/home.dart';
// import 'package:hexcolor/hexcolor.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repassword = TextEditingController();
  TextEditingController sk = TextEditingController();
  final _formSignupKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    email.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    email.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print('email text field: ${email.text}');
  }

  @override
  Widget build(BuildContext context) {
    // User? user;

    double screenWidth = MediaQuery.of(context).size.width;
    ThemeProvider themes = ThemeProvider();

    bool passwordVisible = false;
    bool repasswordVisible = false;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Center(
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formSignupKey,
                child: Column(
                  children: [
                    Builder(
                      builder: (context) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: TextFormField(
                          // validator: (value) {
                          //   if (value == null || !isEmail(value)) {
                          //     return 'Phone Number is Required!';
                          //   }
                          // },
                          style: TextStyle(color: Theme.of(context).primaryColor),
                          controller: phone,
                          obscureText: false,
                          autofocus: false,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide.none,
                            ),
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                            ),
                            // hintText: 'Email',
                            hintStyle: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                            fillColor: Theme.of(context).highlightColor,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || !isEmail(value)) {
                              return 'Email is not valid!';
                            }
                          },
                          style: TextStyle(color: Theme.of(context).primaryColor),
                          controller: email,
                          obscureText: false,
                          autofocus: false,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide.none,
                            ),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                            ),
                            // hintText: 'Email',
                            hintStyle: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                            fillColor: Theme.of(context).highlightColor,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: TextFormField(
                          controller: password,
                          obscureText: !passwordVisible,
                          autofocus: false,
                          style: TextStyle(color: Theme.of(context).primaryColor),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide.none,
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                            fillColor: Theme.of(context).highlightColor,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                            suffixIcon: IconButton(
                              padding: const EdgeInsets.only(right: 15),
                              icon: Icon(
                                passwordVisible == true ? Icons.visibility_off : Icons.visibility,
                                color: Theme.of(context).primaryColorLight.withOpacity(.6),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: TextFormField(
                          controller: repassword,
                          obscureText: !repasswordVisible,
                          autofocus: false,
                          style: TextStyle(color: Theme.of(context).primaryColor),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide.none,
                            ),
                            labelText: 'Konfirmasi Password',
                            labelStyle: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                            fillColor: Theme.of(context).highlightColor,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                            suffixIcon: IconButton(
                              padding: const EdgeInsets.only(right: 15),
                              icon: Icon(
                                passwordVisible == true ? Icons.visibility_off : Icons.visibility,
                                color: Theme.of(context).primaryColorLight.withOpacity(.6),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ButtonTheme(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const SignIn();
                        }),
                      );

                      // User.connectToApi('2cb9c27e-cc71-4870-95c2-a2a2f4aad07a').then((value) {
                      //   user = value;
                      //   setState(() {});
                      // });
                      // print(email.text);
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.3, vertical: 17),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        )),
                    child: const Text(
                      "Daftar",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah memiliki akun? ',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const SignIn();
                        }),
                      );
                    },
                    child: Text(
                      'Masuk',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
