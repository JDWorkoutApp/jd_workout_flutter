import 'package:flutter/material.dart';
import 'package:workout_app/utils/app_version_checker.dart';
import 'package:workout_app/pages/equip_page/equip_page.dart';
import 'package:workout_app/pages/setting_page/setting_page.dart';
import 'package:workout_app/pages/exercise_page/exercise_page.dart';

import '../record_page/training_record_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.title, this.checkAppVersion = false});
  final String title;
  bool checkAppVersion = true;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  List<Widget> pages = const <Widget>[
    ExercisePage(),
    TrainingRecordPage(),
    EquipPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.checkAppVersion) {
      AppVersionChecker.instance.checkAppVersion(context);
    }

    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).focusColor,
        backgroundColor: Theme.of(context).primaryColorLight,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPage,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_new),
            label: 'WORKOUT',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'RECORD',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'EQUIP',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'SETTING',
          ),
        ],
      ),
    );
  }
}
