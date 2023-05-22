
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/api/training_record_api.dart';
import 'package:workout_app/dialog/choose_equip_dialog.dart';
import 'package:workout_app/list/exercise_list.dart';
import 'package:workout_app/models/equip_summary_model.dart';
import 'package:workout_app/utils/toast_helper.dart';
import '../../models/equip_model.dart';

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  primary: Colors.grey[300],
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Search'),
      ),
    );
  }

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController weightController = TextEditingController();
  TextEditingController repsController = TextEditingController();

  EquipSummaryModel selectedEquip = EquipSummaryModel(
      equip: EquipModel(
        id: 0,
        name: 'Equip select',
        note: '-'
      ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 200.0,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(text: selectedEquip.equip.name),
                      selectionRegistrar: SelectionContainer.maybeOf(context),
                      selectionColor: const Color(0xAF6694e8),
                    ),
                    ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ChooseEquipDialog();
                          },
                        ).then((result) {
                          setState(() {
                            selectedEquip = result as EquipSummaryModel;
                          });
                        });
                      },
                      child: Text('Equip select'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: weightController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            // Show decimal keyboard on mobile devices
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}')),
                              // Allow only numbers and dots up to 2 decimal places
                            ],
                            decoration: InputDecoration(
                              labelText: 'Weight',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter weight';
                              }

                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: repsController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}')),
                              // Allow only numbers and dots up to 2 decimal places
                            ], // Show decimal keyboard on mobile devices
                            decoration: InputDecoration(
                              labelText: 'reps',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter reps';
                              }

                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (selectedEquip.equip.id == 0) {
                            ToastHelper.fail("Please select equipment");
                            return;
                          }

                          TrainingRecordApi.store(
                            selectedEquip.equip.id,
                            double.tryParse(weightController.text) ?? 0,
                            double.tryParse(repsController.text) ?? 0,
                            ''
                          ).then((value) {
                            ToastHelper.success('success');
                          }).catchError((error) {
                            ToastHelper.fail('fail');
                          });
                        }
                      },
                      child: const Text('Add record'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 下半部份的運動紀錄分頁資料
          Expanded(
            child: Scaffold(
              body: ExerciseList(),
            )
          ),
        ],
      ),
    );
  }
}