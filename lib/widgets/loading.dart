import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:structure_example/resource/images_data.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: Container(
          width: 72,
          height: 72,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(ImagesData.img_splash_iconapp),
              Container(
                width: 72,
                height: 72,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
