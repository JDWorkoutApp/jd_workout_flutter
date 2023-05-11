import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const RegisterForm({
    required this.userNameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TextFormField(
            controller: widget.userNameController,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              labelText: 'Username',
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
                return 'Please enter username';
              }

              return null;
            },
          ),
        ),
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
        )
      ],
    );
  }
}
