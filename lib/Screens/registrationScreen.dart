// import 'dart:js'; 
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riderapp/Screens/loginscreen.dart';
import 'package:riderapp/Screens/mainscreen.dart';
import 'package:riderapp/Widgets/progressDialog.dart';
import 'package:riderapp/main.dart';

class RegisterScreen extends StatelessWidget {
  // const RegisterScreen({Key key}) : super(key: key);
  static const idscreen = "register";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
                height: 20,
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
                "Register as a rider",
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
                      keyboardType: TextInputType.text,
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Name",
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
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: "Phone",
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
                            "Register",
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
                        if(nameController.text.length< 4){
                          displaytoast("Name must be atleast 3 characters",context);

                        }
                        else if(!emailController.text.contains("@")){
                          displaytoast("Enter valid email", context);
                        }
                        else if(phoneController.text.isEmpty){
                          displaytoast("Phone number is empty", context);

                        }
                        else if(passwordController.text.length<3){
                          displaytoast("Password is not strong", context);
                        }
                        else{

                           registerNewuser(context);

                        }
                       
                        // print("register button Pressed");
                  // Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idscreen, (route) => false);

                      },
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                     Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idscreen, (route) => false);

                },
                child: Text(
                  "Already have an Account? login here",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
  void registerNewuser(BuildContext context)async
  {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog("Authenticating please wait..");
        });
    final User firebaseUser = (await _firebaseAuth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).catchError((ermg){
      Navigator.pop(context);
      displaytoast("Error" + ermg.toString(), context);
    })).user;

    if(firebaseUser != null){

      Map userDataMap  = {
        "name":nameController.text.trim(),
        "email":emailController.text.trim(),

        "phone":phoneController.text.trim(),
        // "password":passwordController.text.trim(),

      };
      usersRef.child(firebaseUser.uid).set(userDataMap);
      displaytoast("Congratulation! your account is created", context);
      Navigator.pushNamedAndRemoveUntil(context, Mainscreen.idscreen, (route) => false);

      // save to database
    }
    else{
          Navigator.pop(context);
          displaytoast("Failed to create account", context);


    }


  }

  
}


displaytoast(String message, BuildContext context){
        Fluttertoast.showToast(msg: message);

  }
