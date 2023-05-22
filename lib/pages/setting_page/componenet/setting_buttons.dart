import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/pages/login_page/login_page.dart';

class SettingButtons extends StatelessWidget {
  const SettingButtons();

  void _logout(BuildContext context) async {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove("jwtToken");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(10),
            backgroundColor: Theme.of(context).cardColor,
            foregroundColor: Theme.of(context).hintColor,
            side: BorderSide(color: Theme.of(context).shadowColor, width: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: () => _logout(context),
          child: const Text(
            'LOGOUT',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
    ]);
  }
}