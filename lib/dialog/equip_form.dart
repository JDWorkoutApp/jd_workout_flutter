import 'package:flutter/material.dart';
import 'package:workout_app/api/equip.dart';
import 'package:workout_app/utils/toast_helper.dart';

class EquipDialog extends StatefulWidget {
  @override
  _EquipDialogState createState() => _EquipDialogState();
}

class _EquipDialogState extends State<EquipDialog> {
  final _nameController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool result;
    return AlertDialog(
      title: Text("Add Equipm"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'name'),
          ),
          TextFormField(
            controller: _noteController,
            decoration: InputDecoration(labelText: 'note'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.pop(context, null);
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () async {
            result = await EquipApi.store(_nameController.text, _noteController.text);
            if (result) {
              ToastHelper.success("Success");
              Navigator.pop(context, null);
            } else {
              ToastHelper.fail("error");
            }
          },
          child: Text("Save"),
        ),
      ],
    );
  }
}