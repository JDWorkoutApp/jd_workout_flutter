import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrainingRecordDialog extends StatefulWidget {
  double? weight;
  double? reps;
  String? note;

  TrainingRecordDialog({
    Key? key,
    this.weight,
    this.reps,
    this.note,
  }) : super(key: key);

  @override
  _TrainingRecordDialogState createState() => _TrainingRecordDialogState();
}

class _TrainingRecordDialogState extends State<TrainingRecordDialog> {
  final _WeightController = TextEditingController();
  final _RepController = TextEditingController();
  final _NoteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _WeightController.text = widget.weight.toString();
    _RepController.text = widget.reps.toString();
    _NoteController.text = widget.note!;
  }

  @override
  void dispose() {
    _WeightController.dispose();
    _RepController.dispose();
    _NoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("TRAINING RECORD"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _WeightController,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
            ],
            decoration: InputDecoration(labelText: 'weight'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter weight';
              }

              return null;
            },
          ),
          TextFormField(
            controller: _RepController,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
            ],
            decoration: InputDecoration(labelText: 'reps'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter reps';
              }

              return null;
            },
          ),
          TextFormField(
            controller: _NoteController,
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
              "weight": double.parse(_WeightController.text),
              "reps": double.parse(_RepController.text),
              "note": _NoteController.text,
            });
          },
          child: Text("Save"),
        ),
      ],
    );
  }
}
