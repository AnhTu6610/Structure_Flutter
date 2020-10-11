import 'package:structure_example/resource/colors_data.dart';
import 'package:structure_example/resource/dimen.dart';
import 'package:structure_example/resource/fonts_name.dart';
import 'package:structure_example/views/login/login_screen.dart';
import 'package:structure_example/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: MyApp.navigatorKey,
      title: 'Structure example',
      home: SplashScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/login":
            return PageTransition(
              child: LoginScreen(),
              type: PageTransitionType.rightToLeft,
              settings: RouteSettings(name: "/register"),
            );

          case "/splash":
            return PageTransition(
              child: SplashScreen(),
              type: PageTransitionType.rightToLeft,
              settings: RouteSettings(name: "/splash"),
            );
            break;

          default:
            return PageTransition(
              child: SplashScreen(),
              type: PageTransitionType.rightToLeft,
              settings: RouteSettings(name: "/splash"),
            );
        }
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.blue,
        fontFamily: FontsName.nunito_Regular,
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        dividerColor: ColorsData.grey_1,
        textTheme: TextTheme(
          headline4: TextStyle(
            color: ColorsData.green_1,
            fontFamily: FontsName.nunito_Bold,
          ),
          headline5: TextStyle(
            color: ColorsData.green_1,
            fontFamily: FontsName.nunito_Bold,
          ),
          bodyText1: TextStyle(
            color: ColorsData.grey_1,
            fontFamily: FontsName.nunito_Regular,
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: ColorsData.blue_1,
        ),
        dialogBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(),
        primaryTextTheme: TextTheme(
          button: TextStyle(
            color: Colors.white,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: ColorsData.green_1,
          unselectedItemColor: ColorsData.grey_1,
          selectedIconTheme: IconThemeData(
            color: ColorsData.green_1,
          ),
          unselectedIconTheme: IconThemeData(
            color: ColorsData.grey_1,
          ),
          selectedLabelStyle: TextStyle(
            fontFamily: FontsName.nunito_Bold,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: FontsName.nunito_Bold,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: ColorsData.green_1,
          textTheme: ButtonTextTheme.normal,
          colorScheme: ColorScheme.dark(),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          padding: EdgeInsets.symmetric(vertical: 10),
        ),
        backgroundColor: ColorsData.background,
        brightness: Brightness.light,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: ColorsData.fillInput,
          isDense: false,
          labelStyle: TextStyle(
            color: ColorsData.lableInput,
          ),
          prefixStyle: TextStyle(color: ColorsData.iconInput),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimen.borderInput),
            borderSide: BorderSide(color: ColorsData.boderInput),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimen.borderInput),
            borderSide: BorderSide(color: ColorsData.boderInput),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimen.borderInput),
            borderSide: BorderSide(color: ColorsData.green_1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimen.borderInput),
            borderSide: BorderSide(color: Colors.red),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimen.borderInput),
            borderSide: BorderSide(color: Colors.red),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
        ),
      ),
    );
  }
}
