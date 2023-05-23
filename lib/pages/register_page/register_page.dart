import 'package:flutter/material.dart';
import 'package:workout_app/pages/register_page//component/button_group.dart';
import 'package:workout_app/pages/register_page/component/register_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login-background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: Row(),
              ),
              Expanded(
                  flex: 6,
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8),
                        child: RegisterForm(
                            userNameController: _usernameController,
                            emailController: _emailController,
                            passwordController: _passwordController),
                      ))),
              Expanded(
                  flex: 2,
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8),
                        child: ButtonGroup(
                          formKey: _formKey,
                          usernameController: _usernameController,
                          emailController: _emailController,
                          passwordController: _passwordController,
                        ),
                      ))),
              Expanded(flex: 4, child: Row())
            ],
          ),
        ),
      ),
    );
  }
}
