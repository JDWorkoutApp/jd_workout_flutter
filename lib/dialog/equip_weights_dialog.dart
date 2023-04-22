import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class EquipWeightDialog extends StatefulWidget {
  const EquipWeightDialog({Key? key}) : super(key: key);

  @override
  _EquipWeightDialogState createState() => _EquipWeightDialogState();
}

class _EquipWeightDialogState extends State<EquipWeightDialog> {
  final _EquipWeights = <double>[];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add EquipWeights'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < _EquipWeights.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                initialValue: _EquipWeights[i].toString(),
                keyboardType:
                    TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d*'))
                ],
                decoration: InputDecoration(
                  labelText: 'EquipWeight ${i + 1}',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _EquipWeights[i] = double.tryParse(value) ?? 0;
                },
              ),
            ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _EquipWeights.add(0);
              });
            },
            child: const Text('Add'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, _EquipWeights);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}