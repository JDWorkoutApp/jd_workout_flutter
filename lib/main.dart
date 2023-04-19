import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/home_page.dart';
import 'package:workout_app/login_page.dart';
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
    if (_needCheckLogin) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    if (_isLogin) {
      return const MaterialApp(
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      );
    }
    return const MaterialApp(
      home: LoginPage()
    );
  }
}