import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vizor/components/atoms/vizor_frame.dart';
import 'package:workout_app/dialog/choose_equip_dialog.dart';
import 'package:workout_app/list/exercise_list_sliver.dart';
import 'package:workout_app/models/equip_summary_model.dart';
import '../../api/training_record_api.dart';
import '../../models/equip_model.dart';
import '../../utils/toast_helper.dart';

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
  TextEditingController equipController = TextEditingController();

  EquipSummaryModel selectedEquip = EquipSummaryModel(
    equip: EquipModel(id: 0, name: 'Equip select', note: '-'),
  );

  final _equipImageList = [
    'assets/images/back-training.jpg',
    'assets/images/leg-training.png',
    'assets/images/chest-training.png',
  ];

  int currentEquipImageIndex = Random().nextInt(3);
  GlobalKey<ExerciseListSliverState> exerciseListSliverKey =
      GlobalKey<ExerciseListSliverState>();

  List<int> commonReps = [1, 3, 5, 8, 10, 12, 15, 20, 25];

  @override
  Widget build(BuildContext context) {
    // Color borderColor = Color(0xFF27CEED);
    Color borderColor = Theme.of(context).secondaryHeaderColor;
    Color darkColor = Color(0xFF1D0E1A);
    Color appBarBackgroundColor = Theme.of(context).primaryColorLight;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          toolbarHeight: 360,
          backgroundColor: appBarBackgroundColor,
          title: VizorFrame(
            lineColor: borderColor,
            lineStroke: 3.0,
            cornerStroke: 7.0,
            cornerLengthRatio: 0.1,
            child: Container(
                height: 310,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: darkColor,
                  image: DecorationImage(
                    image: AssetImage(_equipImageList[currentEquipImageIndex]),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.8),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(flex: 3,child: Text('EQUIP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                            )
                            )),
                            Expanded(
                              flex: 7,
                                child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ChooseEquipDialog();
                                        },
                                      ).then((result) {
                                        setState(() {
                                          selectedEquip =
                                              result as EquipSummaryModel;

                                          equipController.text = selectedEquip.equip.name;

                                          currentEquipImageIndex = Random().nextInt(3);
                                        });
                                      });
                                    },
                                  child: AbsorbPointer(
                                    absorbing: true,
                                    child: TextFormField(
                                  style: TextStyle(fontSize: 12),
                              controller: equipController,
                              cursorColor: Colors.white,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select equip';
                                }

                                return null;
                              },
                            ),
                                  )
                                )),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text('MAX WEIGHT: ' + (selectedEquip.maxWeightRecord?.weight.toString() ?? "-"),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text('MAX WEIGHT REPS: ' + (selectedEquip.maxWeightRecord?.reps.toString() ?? "-"),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      )),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(flex: 3,child: Text('WEIGHT', style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                            ))),
                            Expanded(
                              flex: 7,
                                child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                              ],
                              style: TextStyle(fontSize: 12),
                              controller: weightController,
                              cursorColor: Colors.white,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter weight';
                                }

                                return null;
                              },
                            )),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Row(
                            // selectedEquip.equip.weights to buttons
                            children: selectedEquip.equip.weights != null
                                ? selectedEquip.equip.weights?.map((e) {
                                    return Expanded(
                                        child: Container(
                                      margin: EdgeInsets.all(5),
                                      child: ElevatedButton(
                                        style: raisedButtonStyle,
                                        onPressed: () {
                                          setState(() {
                                            weightController.text = e.toString();
                                          });
                                        },
                                        child: Text(e.toString()),
                                      ),
                                    ));
                                  }).toList() ?? []
                                : [],
                          )
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(flex: 3,child: Text('REPS', style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                            ))),
                            Expanded(
                              flex: 7,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                                  ],
                                  style: TextStyle(fontSize: 12),
                              controller: repsController,
                              cursorColor: Colors.white,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter reps';
                                }

                                return null;
                              },
                            )),
                          ],
                        ),
                      ),
                      Expanded(child:
                          Row(
                            children: commonReps.map((e) {
                              return Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    child: ElevatedButton(
                                      style: raisedButtonStyle,
                                      onPressed: () {
                                        setState(() {
                                          repsController.text = e.toString();
                                        });
                                      },
                                      child: Text(e.toString()),
                                    ),
                                  ));
                            }).toList(),
                          )
                      ),
                      Expanded(child: Container(height: 20,)),
                      Expanded(
                          child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.all(10),
                              child: VizorFrame(
                                color: Color(0xFF7D0F2A),
                                lineColor: Color(0xFFEA3733),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'RESET',
                                      style: TextStyle(
                                        color: Color(0xFFFBFFFE),
                                        fontSize: 15,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  if (selectedEquip.equip.id == 0) {
                                    ToastHelper.fail("Please select equipment");
                                    return;
                                  }

                                  TrainingRecordApi.store(
                                          selectedEquip.equip.id,
                                          double.tryParse(
                                                  weightController.text) ??
                                              0,
                                          double.tryParse(
                                                  repsController.text) ??
                                              0,
                                          '')
                                      .then((value) {
                                    ToastHelper.success('success');
                                    exerciseListSliverKey.currentState!
                                        .refreshList();
                                  }).catchError((error) {
                                    ToastHelper.fail('fail');
                                  });
                                }
                              },
                              child: Container(
                                height: 50,
                                padding: EdgeInsets.all(10),
                                child: VizorFrame(
                                  color: Color(0xFF093B46),
                                  lineColor: Color(0xFF05C3CF),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'SUBMIT',
                                        style: TextStyle(
                                          color: Color(0xFF05C3CF),
                                        fontSize: 15,
                                      ),
                                    )),
                              ),
                            ),
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                )),
          ),
          floating: false,
          pinned: true,
          snap: false,
        ),
        SliverAppBar(
          backgroundColor: appBarBackgroundColor,
          forceElevated: true,
          elevation: 0,
          toolbarHeight: 30,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF230A24),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -5,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    color: Colors.transparent,
                    child: VizorFrame(
                        lineStroke: 1.5,
                        cornerStroke: 4.5,
                        child: Container(
                          height: 20,
                          width: 100,
                          child: Center(
                              child: Text(
                            'RECORDS',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        )),
                  ),
                ),
              ],
            ),
          ),
          floating: false,
          pinned: true,
          snap: false,
        ),
        ExerciseListSliver(key: exerciseListSliverKey)
      ],
    ));
  }
}
