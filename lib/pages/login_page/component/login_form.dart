import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    required this.emailController,
    required this.passwordController,
  });

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TextFormField(
            controller: widget.emailController,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              labelText: 'Email',
              filled: true,
              fillColor: Colors.grey.withOpacity(0.2),
              labelStyle:
                  TextStyle(color: Theme.of(context).secondaryHeaderColor),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).secondaryHeaderColor),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).secondaryHeaderColor),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter email';
              }

              return null;
            },
          ),
        ),
        Expanded(
          child: TextFormField(
            controller: widget.passwordController,
            cursorColor: Colors.white,
            obscureText: obscureText,
            decoration: InputDecoration(
              labelText: 'Password',
              filled: true,
              fillColor: Colors.grey.withOpacity(0.2),
              labelStyle:
                  TextStyle(color: Theme.of(context).secondaryHeaderColor),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).secondaryHeaderColor),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).secondaryHeaderColor),
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: IconTheme(
                  data: const IconThemeData(
                    color: Colors.white,
                  ),
                  child: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }
              return null;
            },
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              'Forgot password',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
