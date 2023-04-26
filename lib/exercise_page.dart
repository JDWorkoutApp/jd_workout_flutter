
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/dialog/choose_equip_dialog.dart';
import 'package:workout_app/list/exercise_list.dart';
import 'models/equip_model.dart';

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
  // 宣告一些變數和資料庫存取相關的屬性
  // ...

  EquipModel selectedEquip = EquipModel(
      id: 0,
      name: '-',
      note: '-'
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 200.0,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  RichText(
                    text: TextSpan(text: selectedEquip.name),
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
                            selectedEquip = result as EquipModel;
                        });
                      });
                    },
                    child: Text('選擇器材'),
                  ),
                  // 輸入重量和 reps 的欄位
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.numberWithOptions(decimal: true), // Show decimal keyboard on mobile devices
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')), // Allow only numbers and dots up to 2 decimal places
                          ],
                          decoration: InputDecoration(
                            labelText: '輸入重量',
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')), // Allow only numbers and dots up to 2 decimal places
                          ],// Show decimal keyboard on mobile devices
                          decoration: InputDecoration(
                            labelText: '輸入 reps',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  // 送出按鈕
                  ElevatedButton(
                    style: raisedButtonStyle,
                    onPressed: () {
                      // 儲存運動紀錄到資料庫
                      // ...
                    },
                    child: const Text('送出'),
                  ),
                ],
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