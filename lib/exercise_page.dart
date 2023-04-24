
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // 上半部份固定的表格
          Container(
            height: 200.0,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  DropdownButton<String>(
                    items: const [
                      DropdownMenuItem<String>(
                        value: 'none',
                        child: Text('選擇器材'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'dumbbell',
                        child: Text('啞鈴'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'treadmill',
                        child: Text('跑步機'),
                      ),
                    ],
                    onChanged: (value) {
                      // 改變選擇器材的值
                      // ...
                    },
                    value: 'none',
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
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                // 取得資料庫裡的運動紀錄
                // ...

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text('運動日期：2022-01-01'),
                          SizedBox(height: 4.0),
                          Text('器材：測試'),
                          SizedBox(height: 4.0),
                          Text('重量：20'),
                          SizedBox(height: 4.0),
                          Text('Reps：5'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}