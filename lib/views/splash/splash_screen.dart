import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:structure_example/bloc/authen/bloc_profile.dart';
import 'package:structure_example/bloc/shopping/bloc_order.dart';
import 'package:structure_example/data_source/local_data/location_offline.dart';
import 'package:structure_example/data_source/local_data/preference_provider.dart';
import 'package:structure_example/data_source/local_data/sqlite_provider.dart';
import 'package:structure_example/resource/images_data.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LocationOffline _locationOffline = new LocationOffline();
  SqliteProvider _sqliteProvider = new SqliteProvider();
  _handleFirstScreen() async {
    await _sqliteProvider.openDB();
    await _locationOffline.getCitys();
    await Future.delayed(Duration(seconds: 1));
    if (await PreferenceProvider.getToken() != null) {
      if (await Provider.of<BlocProfile>(context, listen: false).getProflie()) {
        context.read<BlocOrder>().loadListProductCart();
        Navigator.of(context).pushReplacementNamed("/home");
      } else {
        _handleFirstScreen();
      }
    } else {
      Navigator.of(context).pushReplacementNamed("/login");
    }
  }

  @override
  void initState() {
    super.initState();
    _handleFirstScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Container(
          //   width: double.infinity,
          //   height: double.infinity,
          //   child: Image.asset(ImagesData.img_splash_backgroud, fit: BoxFit.cover),
          // ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Stack(
              children: [
                Image.asset(ImagesData.img_splash_iconapp),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
