import 'package:flutter/material.dart';
import 'package:workout_app/api/auth.dart';
import 'package:workout_app/utils/toast_helper.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
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
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _oldPasswordController,
                              obscureText: true,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                labelText: 'Old Password',
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.2),
                                labelStyle: TextStyle(
                                    color:
                                        Theme.of(context).secondaryHeaderColor),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter old password';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _newPasswordController,
                              obscureText: true,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                labelText: 'New Password',
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.2),
                                labelStyle: TextStyle(
                                    color:
                                        Theme.of(context).secondaryHeaderColor),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter new password';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _confirmNewPasswordController,
                              obscureText: true,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                labelText: 'Confirm New Password',
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.2),
                                labelStyle: TextStyle(
                                    color:
                                        Theme.of(context).secondaryHeaderColor),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm new password';
                                }

                                if (value != _newPasswordController.text) {
                                  return 'Passwords do not match';
                                }

                                return null;
                              },
                            ),
                          ],
                        ),
                      ))),
              Expanded(
                  flex: 2,
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8),
                        child: Column(children: [
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
                                if (_formKey.currentState!.validate()) {
                                  AuthApi.resetPassword(
                                          oldPassword:
                                              _oldPasswordController.text.trim(),
                                          newPassword:
                                              _newPasswordController.text.trim(),
                                          confirmNewPassword:
                                              _confirmNewPasswordController.text
                                                  .trim())
                                      .then((value) {
                                    if (value) {
                                      ToastHelper.success("Reset success");
                                      Navigator.pop(context);
                                    }
                                  }).catchError((error) {
                                    if (error.message &&
                                        error.message['statusCode'] &&
                                        error.message['statusCode'] == 401) {
                                      ToastHelper.fail("Wrong old password");
                                    } else {
                                      ToastHelper.fail("Reset failed");
                                    }
                                  });
                                }
                              },
                              child: const Text('RESET PASSWORD'),
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
                        ]),
                      ))),
              Expanded(flex: 4, child: Row())
            ],
          ),
        ),
      ),
    );
  }
}