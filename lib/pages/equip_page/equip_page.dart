import 'package:flutter/material.dart';
import 'package:workout_app/api/equip_api.dart';
import 'package:workout_app/list/equip_list.dart';
import 'package:workout_app/utils/toast_helper.dart';
import '../../dialog/equip_dialog.dart';

class EquipPage extends StatefulWidget {
  const EquipPage({Key? key});

  @override
  _EquipPageState createState() => _EquipPageState();
}

class _EquipPageState extends State<EquipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EquipList(), // add the InfiniteList widget here
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EquipDialog();
            },
          ).then((result) {
            if (result != false) {
              EquipApi.store(result['name'], result['note']).then((apiResult) {
                if (apiResult) {
                  ToastHelper.success("Added equip");
                } else {
                  ToastHelper.fail("Failed to add equip");
                }
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}