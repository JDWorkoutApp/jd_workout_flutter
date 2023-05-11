import 'package:flutter/material.dart';
import 'package:workout_app/api/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/home_page.dart';
import 'package:workout_app/register_page.dart';
import 'package:workout_app/utils/toast_helper.dart';

class ButtonGroup extends StatelessWidget {
  final formKey;
  final usernameController;
  final emailController;
  final passwordController;

  const ButtonGroup({
    required this.formKey,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
  });

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
          onPressed: () {
            if (formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
              AuthApi.register(
                usernameController.text,
                passwordController.text,
                emailController.text,
              ).then((value) {
                ToastHelper.success("Registration successful");
              }).catchError((error) {
                ToastHelper.fail(error.toString());
              });
            }
          },
          child: const Text('Submit'),
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
            Navigator.pop(context);
          },
          child: const Text(
            'BACK',
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
