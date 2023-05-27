import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vizor/components/atoms/vizor_frame.dart';
import 'package:workout_app/api/equip_api.dart';
import 'package:workout_app/list/equip_list_sliver.dart';
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
    GlobalKey<EquipListSliverState> equipListState = GlobalKey();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight:0,
            collapsedHeight: 0,
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            expandedHeight: 100,
            floating: false,
            pinned: true,
            snap: false,
            flexibleSpace: Container(
              child: VizorFrame(
                child: SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: const [
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "EQUIP MANAGEMENT",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF61F7D4),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "AMOUNT: 20",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF61F7D4),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "UPDATE TIME: 2022-05-05 12:00:00",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF61F7D4),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // flexibleSpace: FlexibleSpaceBar(
            //   background: Container(
            //     decoration: BoxDecoration(
            //       image: DecorationImage(
            //         image: AssetImage("assets/images/equipment.png"),
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //   ),
            // )
          ),
          EquipListSliver(
            key: equipListState,
          )
        ],
      ),
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