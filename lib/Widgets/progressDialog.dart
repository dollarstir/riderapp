import 'dart:ui';

import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  // const ProgressDialog({Key key}) : super(key: key);

  String dmessage;
  ProgressDialog(this.dmessage);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.yellow,
      child: Container(
        margin: EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            SizedBox(
              width: 6,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
            SizedBox(width: 26),
            Text(
              dmessage,
              style: TextStyle(
                color: Colors.black,
                fontSize: 10,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
