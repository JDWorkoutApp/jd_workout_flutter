import 'package:flutter/material.dart';
import 'package:workout_app/api/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/home_page.dart';
import 'package:workout_app/register_page.dart';

class ButtonGroup extends StatelessWidget {
  final formKey;
  final emailController;
  final passwordController;

  const ButtonGroup({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  void _loginSubmit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final navigator = Navigator.of(context);

      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      try {
        Map<String, dynamic> response =
            await AuthApi.login(emailController.text, passwordController.text);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwtToken', response["jwtToken"]);

        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('Login success')),
        );

        navigator.pushReplacement(
          MaterialPageRoute(
              builder: (context) => const MyHomePage(title: "from login page")),
        );
      } catch (e) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('Login failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(10),
            backgroundColor: Colors.black,
            foregroundColor: Colors.yellow,
            side: const BorderSide(color: Colors.yellow),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () => _loginSubmit(context),
          child: const Text(
            'LOGIN',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(10),
            backgroundColor: Colors.black,
            foregroundColor: Colors.yellow,
            side: const BorderSide(color: Colors.yellow),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterPage()),
            );
          },
          child: const Text(
            'REGISTER',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    ]);
  }
}
