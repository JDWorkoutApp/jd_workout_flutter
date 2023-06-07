import 'package:flutter/material.dart';
import '../../utils/app_version_checker.dart';
import '../equip_page/equip_page.dart';
import '../exercise_page/exercise_page.dart';
import '../record_page/training_record_page.dart';
import '../setting_page/setting_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title, this.checkAppVersion = false}) : super(key: key);

  final String title;
  final bool checkAppVersion;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> pages = const <Widget>[
    ExercisePage(),
    TrainingRecordPage(),
    EquipPage(),
    SettingPage(),
  ];

  int currentPage = 0;

  void checkAppVersion(BuildContext context) {
    AppVersionChecker.instance.checkAppVersion(context);
  }

  void handlePageTap(int value) {
    setState(() {
      currentPage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.checkAppVersion) {
      checkAppVersion(context);
    }

    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).focusColor,
        backgroundColor: Theme.of(context).primaryColorLight,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPage,
        onTap: handlePageTap,
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
