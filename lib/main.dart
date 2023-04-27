import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/home_page.dart';
import 'package:workout_app/pages/login_page/login_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwtToken');
    if (token == null) {
      return false;
    }

    return true;
    // return true;
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
      homeWidget = MyHomePage(title: 'Flutter Demo Home Page');
    } else {
      homeWidget = LoginPage();
    }

    return MaterialApp(
      home: homeWidget,
      theme: ThemeData(
          fontFamily: 'RobotoMono',
          brightness: Brightness.dark,
          secondaryHeaderColor: const Color(0xFFFFD700),
      ),
    );
  }
}