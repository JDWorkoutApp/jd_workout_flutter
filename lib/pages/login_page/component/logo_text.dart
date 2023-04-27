import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  const LogoText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'GOVELFIT',
      style: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Theme.of(context).secondaryHeaderColor,
      ),
    );
  }
}