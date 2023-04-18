import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
      ),
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