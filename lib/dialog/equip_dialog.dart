import 'package:flutter/material.dart';

class EquipDialog extends StatefulWidget {
  var name;
  var note;

  EquipDialog({this.name = '', this.note = ''});
  @override
  _EquipDialogState createState() => _EquipDialogState();
}

class _EquipDialogState extends State<EquipDialog> {
  final _nameController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _noteController.text = widget.note;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Equipment"),
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