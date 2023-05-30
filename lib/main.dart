import 'package:flutter/material.dart';
import 'package:workout_app/pages/home_page/home_page.dart';
import 'package:workout_app/pages/login_page/login_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workout_app/utils/auth_helper.dart';
import 'oauth/firebase_options.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  if (dotenv.env['SENTRY_DSN'] != null) {
    await SentryFlutter.init(
      (options) {
        options.dsn = dotenv.env['SENTRY_DSN'];
        options.tracesSampleRate = 1.0;
      },
      appRunner: () => runApp(MyApp()),
    );
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool _needCheckLogin = true;
  bool _isLogin = false;

  Future<bool> _checkLogin() async {
    String? token = await AuthHelper.getJwtToken();
    if (token == null) {
      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    _checkLogin().then((value) {
      setState(() {
        _needCheckLogin = false;
        _isLogin = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget homeWidget;

    if (_needCheckLogin) {
      homeWidget = const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (_isLogin) {
      homeWidget = HomePage(title: 'Flutter Demo Home Page', checkAppVersion: true);
    } else {
      homeWidget = LoginPage();
    }

    return MaterialApp(
      home: homeWidget,
      debugShowCheckedModeBanner: dotenv.env['DEBUG_SHOW_CHECK_MODE_BANNER'] == 'true',
      theme: ThemeData(
          fontFamily: 'RobotoMono',
          brightness: Brightness.dark,
          secondaryHeaderColor: const Color(0xFFFFD700),
          primaryColorLight: const Color(0xFF362839),
          primaryColor: const Color(0xFFF1E3F2),
          focusColor: const Color(0xFFFF0234),
          scaffoldBackgroundColor: const Color(0xFF280C2A),
          shadowColor: const Color(0xFFFE413C),
          cardColor: const Color(0xFF8E2E2C),
          hintColor: const Color(0xFFD74946),
      ),
    );
  }
}