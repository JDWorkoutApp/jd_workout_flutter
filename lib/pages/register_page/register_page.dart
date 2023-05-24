import 'package:animated_glitch/animated_glitch.dart';
import 'package:flutter/material.dart';
import 'package:workout_app/pages/login_page/component/logo_text.dart';
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
  final _animateController = AnimatedGlitchController(
    frequency: const Duration(milliseconds: 200),
    level: 1.2,
    distortionShift: const DistortionShift(count: 3),
  );
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
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedGlitch(
                controller: _animateController,
                child: Image.asset(
                  'assets/images/login-background.png',
                  fit: BoxFit.cover,
                )),
          ),
          Form(
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
                  flex: 2,
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
          )
        ],
      ),
    );
  }
}
