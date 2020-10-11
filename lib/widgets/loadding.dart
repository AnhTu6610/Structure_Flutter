import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loadding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: Container(
          width: 70,
          height: 70,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: FittedBox(child: CupertinoActivityIndicator()),
        ),
      ),
    );
  }
}
