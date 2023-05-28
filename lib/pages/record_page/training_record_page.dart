import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vizor/components/atoms/vizor_frame.dart';
import 'package:workout_app/list/equip_list_sliver.dart';
import 'package:workout_app/list/training_record_list_sliver.dart';

class TrainingRecordPage extends StatefulWidget {
  const TrainingRecordPage({Key? key});

  @override
  TrainingRecordPageState createState() => TrainingRecordPageState();
}

class TrainingRecordPageState extends State<TrainingRecordPage> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<EquipListSliverState> equipListState = GlobalKey();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            expandedHeight: 25,
            floating: false,
            pinned: true,
            snap: false,
          ),
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
                lineColor: Color(0xFFFDFDFD),
                color: Color(0xFF101010),
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
                            "RECORD MANAGEMENT",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFFFAFAFA),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "AMOUNT: 1005",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFFFAFAFA),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "UPDATE TIME: 2023-04-01 07:11:00",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFFFAFAFA),
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
          ),
          TrainingRecordListSliver(
            key: equipListState,
          )
        ],
      ),
    );
  }
}