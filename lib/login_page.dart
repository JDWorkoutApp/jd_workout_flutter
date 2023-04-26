import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:workout_app/api/auth.dart';
import 'package:workout_app/home_page.dart';
import 'package:workout_app/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/login-background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                }

                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  final navigator = Navigator.of(context);

                  scaffoldMessenger.showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );

                  try {
                    Map<String, dynamic> response = await AuthApi.login(
                        _emailController.text, _passwordController.text);
                    SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                    await prefs.setString('jwtToken', response["jwtToken"]);
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(content: Text('Login success')),
                    );

                    navigator.pushReplacement(
                      MaterialPageRoute(
                          builder: (context) =>
                              const MyHomePage(title: "from login page")),
                    );
                  } catch (e) {
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(content: Text('Login failed')),
                    );
                  }
                }
              },
              child: const Text('Submit'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
