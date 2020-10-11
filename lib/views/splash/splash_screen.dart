import 'package:structure_example/data_source/local_data/preference_provider.dart';
import 'package:structure_example/resource/images_data.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pushReplacementNamed("/login");
      // Navigator.of(context).pushReplacementNamed("/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image.asset(
          //   ImagesData.bgUnsplash,
          //   fit: BoxFit.cover,
          // ),
          CircularProgressIndicator()
        ],
      ),
    );
  }
}
