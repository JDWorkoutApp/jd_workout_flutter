
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/api/training_record_api.dart';
import 'package:workout_app/dialog/choose_equip_dialog.dart';
import 'package:workout_app/list/exercise_list_sliver.dart';
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
        body: CustomScrollView(
      slivers: [ExerciseListSliver()],
    ));
  }
}