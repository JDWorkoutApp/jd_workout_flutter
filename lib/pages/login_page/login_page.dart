import 'package:flutter/material.dart';
import 'package:workout_app/pages/login_page/component/button_group.dart';
import 'package:workout_app/pages/login_page/component/login_form.dart';
import 'package:workout_app/pages/login_page/component/logo_text.dart';

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
              const Expanded(
                  flex: 5,
                  child: Align(
                    alignment: Alignment.center,
                    child: LogoText(),
                  )),
              Expanded(
                  flex: 4,
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8),
                        child: LoginForm(
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
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.8),
                          child: ButtonGroup(
                            formKey: _formKey,
                            emailController: _emailController,
                            passwordController: _passwordController,
                          )))),
              Expanded(flex: 4, child: Row())
            ],
          ),
        ),
      ),
    );
  }
}
