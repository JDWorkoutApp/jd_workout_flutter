import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vizor/components/atoms/vizor_frame.dart';
import 'package:workout_app/api/training_record_api.dart';
import 'package:workout_app/models/training_summary_model.dart';

class ExerciseListSliver extends StatefulWidget {
  const ExerciseListSliver({Key? key}) : super(key: key);

  @override
  ExerciseListSliverState createState() => ExerciseListSliverState();
}

class ExerciseListSliverState extends State<ExerciseListSliver> {
  final ScrollController _scrollController = ScrollController();
  List<TrainingSummaryModel> _items = [];
  int _page = 1;
  bool _isLoading = false;
  final _equipImageList = [
    'assets/images/back-training.jpg',
    'assets/images/leg-training.png',
    'assets/images/chest-training.png',
  ];

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);

    _loadMoreItems();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    if (_isLoading) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    var result = await TrainingRecordApi.getDaySummaryList(_page);

    setState(() {
      _items.addAll(result.trainings);
      _page++;
      _isLoading = false;
    });
  }

  dateFormat(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return dateTime.hour.toString().padLeft(2, '0') +
        ':' +
        dateTime.minute.toString().padLeft(2, '0');
  }

  refreshList() {
    setState(() {
      _items = [];
      _page = 1;
      _isLoading = false;
    });

    _loadMoreItems();
  }
  
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == _items.length) {
            return _buildProgressIndicator();
          } else {
            TrainingSummaryModel training = _items[index];

            return Dismissible(
              key: Key(index.toString()),
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: VizorFrame(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(children: [
                            Expanded(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    training.date,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                            Expanded(
                                flex: 4,
                                child: Text(
                                  dateFormat(training.start) +
                                      " ~ " +
                                      dateFormat(training.end),
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                  ),
                                )),
                            Expanded(flex: 4, child: Container())
                          ]),
                          Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Divider(
                                color: Colors.grey,
                                height: 1,
                                thickness: 2,
                              )),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: training.equipments.length,
                            itemBuilder: (context, index) {
                              final equipment = training.equipments[index];
                              return ListTile(
                                title: Row(
                                  children: [
                                    VizorFrame(
                                      child: Container(
                                        height: 50,
                                        child: Image.asset(
                                          _equipImageList[Random().nextInt(3)],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text(" " + equipment.name)
                                  ],
                                ),
                                subtitle: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: equipment.records?.length,
                                  itemBuilder: (context, index) {
                                    final record = equipment.records?[index];
                                    return ListTile(
                                      title: Text("- " +
                                          (record?.weight.toString() ?? '') +
                                          " x " +
                                          (record?.reps.toString() ?? '') +
                                          " x " +
                                          (record?.sets.toString() ?? '')),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "weight x reps x sets",
                              style: TextStyle(
                                color: Theme.of(context).focusColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            );
          }
        },
        childCount: _items.length + 1,
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: _isLoading ? 1.0 : 0.0,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
