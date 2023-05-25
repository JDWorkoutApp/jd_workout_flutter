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
    GlobalKey<EquipListState> equipListState = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        elevation: 0,
        title: Stack(
          children: [
            Text(
              "EQUIP MANAGEMENT",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Theme.of(context).shadowColor,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: EquipList(key: equipListState,), // add the InfiniteList widget here
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
                  equipListState.currentState!.resetList();
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