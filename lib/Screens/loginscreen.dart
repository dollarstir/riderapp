import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riderapp/Screens/Mainscreen.dart';
import 'package:riderapp/Screens/registrationScreen.dart';
import 'package:riderapp/main.dart';
import '../Widgets/progressDialog.dart';

class LoginScreen extends StatelessWidget {
  // const LoginScreen({Key key}) : super(key: key);
  static const idscreen = "login";
  // TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 35,
              ),
              Image(
                image: AssetImage("images/logo.png"),
                width: 390,
                height: 250,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 1,
              ),
              Text(
                "login as a rider",
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Brand Bold",
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 1,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),

                    SizedBox(
                      height: 1,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),

                    // Creating login button
                    SizedBox(
                      height: 10,
                    ),

                    RaisedButton(
                      color: Colors.yellow,
                      textColor: Colors.white,
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Brand Bold",
                            ),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(
                          24,
                        ),
                      ),
                      onPressed: () {
                        if (!emailController.text.contains("@")) {
                          displaytoast("Enter valid email", context);
                        } else if (passwordController.text.isEmpty) {
                          displaytoast("Password is madatory", context);
                        } else {
                          loginUser(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RegisterScreen.idscreen, (route) => false);
                },
                child: Text(
                  "Do not have an Account? Register here",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog("Authenticating please wait..");
        });
    final User firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .catchError((ermg) {
      Navigator.pop(context);
      displaytoast("Error" + ermg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) {
      // Map userDataMap  = {
      //   // "name":nameController.text.trim(),
      //   "email":emailController.text.trim(),

      //   // "phone":phoneController.text.trim(),
      //   // "password":passwordController.text.trim(),

      // };
      usersRef.child(firebaseUser.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, Mainscreen.idscreen, (route) => false);
          displaytoast("You are logged in", context);
        } else {
          Navigator.pop(context);

          _firebaseAuth.signOut();
          displaytoast("Your record deos not exist", context);
        }
      });

      // save to database
    } else {
      Navigator.pop(context);

      displaytoast("Error occured Cannot Sign in", context);
    }
  }
}
