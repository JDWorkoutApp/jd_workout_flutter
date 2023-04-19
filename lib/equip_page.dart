import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/dialog/equip_form.dart';
import 'package:workout_app/login_page.dart';

class EquipPage extends StatelessWidget {
  const EquipPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
              showDialog(
              context: context,
              builder: (BuildContext context) {
                return EquipDialog();
              },
            );
          },
          child: const Text("Add Equipment")
        ),
      ),
    );
  }
}