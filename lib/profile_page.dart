import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/pages/login_page/login_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            SharedPreferences.getInstance().then((prefs) {
              prefs.remove("jwtToken");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginPage()
              ));
            });
          },
          child: const Text("Log out"),
        ),
      ),
    );
  }
}