import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:riderapp/Screens/Mainscreen.dart';
import 'package:riderapp/Screens/loginscreen.dart';
import 'package:riderapp/Screens/registrationScreen.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Brand Bold",
       
        primarySwatch: Colors.blue,
      ),
      initialRoute: Mainscreen.idscreen,
      routes: {
        RegisterScreen.idscreen : (context)=>RegisterScreen(),
        LoginScreen.idscreen : (context)=>LoginScreen(),
        Mainscreen.idscreen : (context)=>Mainscreen(),


      },
    );
  }
}


