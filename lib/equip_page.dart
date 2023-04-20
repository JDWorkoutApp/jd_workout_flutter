import 'package:flutter/material.dart';
import 'package:workout_app/dialog/equip_form.dart';
import 'package:workout_app/list/EquipList.dart';

class EquipPage extends StatefulWidget {
  const EquipPage({Key? key});

  @override
  _EquipPageState createState() => _EquipPageState();
}

class _EquipPageState extends State<EquipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EquipList(), // add the InfiniteList widget here
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EquipDialog();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}