import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:structure_example/app_localizations.dart';
import 'package:structure_example/bloc/authen/bloc_profile.dart';
import 'package:structure_example/bloc/chat/bloc_chat.dart';
import 'package:structure_example/bloc/shopping/bloc_order.dart';
import 'package:structure_example/data_source/local_data/preference_name.dart';
import 'package:structure_example/data_source/local_data/preference_provider.dart';
import 'package:structure_example/generate_route.dart';
import 'package:structure_example/resource/theme_material_app.dart';

import 'package:structure_example/views/splash/splash_screen.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      child: MyApp(),
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<BlocProfile>(create: (_) => BlocProfile()),
        ChangeNotifierProvider<BlocOrder>(create: (_) => BlocOrder()),
        ChangeNotifierProvider<BlocChat>(create: (_) => BlocChat()),
      ],
    ),
  );
}

class StateManager {
  static final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  static int indexPageHandbook = 0;
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GenerateRoute _generateRoute = new GenerateRoute();
  ThemeMaterialApp _themeMaterialApp = new ThemeMaterialApp();
  Locale _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    PreferenceProvider.getString(PreferenceNames.LANGUAGE_CODE, def: "vi").then((value) {
      setState(() {
        this._locale = Locale(value);
      });
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: "structure example",
      navigatorKey: StateManager.navigatorKey,
      debugShowCheckedModeBanner: true,
      onGenerateRoute: (setting) => _generateRoute.checkRoute(setting),
      home: SplashScreen(),
      theme: _themeMaterialApp.themeData,
      locale: _locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      supportedLocales: [
        const Locale('vi', 'VN'),
        const Locale('en', 'US'),
      ],
    );
  }
}
