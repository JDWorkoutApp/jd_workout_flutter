import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:workout_app/api/auth.dart';
import 'package:workout_app/home_page.dart';
import 'package:workout_app/oauth/google_auth.dart';
import 'package:workout_app/pages/login_page/component/button_group.dart';
import 'package:workout_app/pages/login_page/component/login_form.dart';
import 'package:workout_app/pages/login_page/component/logo_text.dart';
import 'package:workout_app/utils/app_version_checker.dart';
import 'package:workout_app/utils/auth_helper.dart';
import 'package:workout_app/utils/loading_helper.dart';
import 'package:workout_app/utils/toast_helper.dart';

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
    AppVersionChecker.instance.checkAppVersion(context);

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
                  flex: 2,
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.8),
                          child: SocialLoginButton(
                            text: 'SIGN IN WITH GOOGLE',
                            buttonType: SocialLoginButtonType.google,
                            onPressed: () {
                              LoadingHelper(context).startLoading();
                              GoogleAuth.signInWithGoogle().then((UserCredential value) {
                                final String googleAccessToken = value.credential?.accessToken ?? '';
                                AuthApi.googleLogin(googleAccessToken).then((value) {
                                  AuthHelper.storeLogin(value['jwtToken']);

                                  ToastHelper.success("Login success");

                                  final navigator = Navigator.of(context);
                                  navigator.pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => HomePage(
                                            title: "from login page")),
                                  );
                                }).catchError((error) {
                                  LoadingHelper(context).stopLoading();
                                  ToastHelper.fail("Fail to login with google");
                                });
                              }).catchError((error) {
                                LoadingHelper(context).stopLoading();
                              });
                            },
                            mode: SocialLoginButtonMode.single,
                          )))),
              Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
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
