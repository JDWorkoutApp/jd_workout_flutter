import 'package:flutter/material.dart';
import 'package:workout_app/api/equip_api.dart';
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
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.pop(context, {
              'name': _nameController.text,
              'note': _noteController.text,
            });
          },
          child: Text("Save"),
        ),
      ],
    );
  }
}