import 'package:animated_glitch/animated_glitch.dart';
import 'package:flutter/material.dart';
import 'package:vizor/components/atoms/vizor_button.dart';
import 'package:vizor/components/atoms/vizor_frame.dart';
import 'package:workout_app/api/equip_api.dart';
import 'package:workout_app/api/training_record_api.dart';
import 'package:workout_app/dialog/equip_dialog.dart';
import 'package:workout_app/dialog/training_record_dialog.dart';
import 'package:workout_app/utils/toast_helper.dart';

import '../models/training_record_model.dart';

class TrainingRecordListSliver extends StatefulWidget {
  const TrainingRecordListSliver({Key? key}) : super(key: key);

  @override
  TrainingRecordListSliverState createState() =>
      TrainingRecordListSliverState();
}

class TrainingRecordListSliverState extends State<TrainingRecordListSliver> {
  final ScrollController _scrollController = ScrollController();
  List<TrainingRecordModel> _items = [];
  int _page = 1;
  bool _isLoading = false;

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

  resetList() {
    setState(() {
      _items = [];
      _page = 1;
      _isLoading = false;
    });

    _loadMoreItems();
  }

  Future<void> _loadMoreItems() async {
    if (_isLoading) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    var result = await TrainingRecordApi.get(_page);

    List<TrainingRecordModel> items = result.records;

    setState(() {
      _items.addAll(items);
      _page++;
      _isLoading = false;
    });
  }

  void showDeleteAlertDialog(
      BuildContext context, TrainingRecordModel item, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text('Make sure to delete?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                TrainingRecordApi.delete(item.id).then((value) {
                  if (value) {
                    setState(() {
                      _items.removeAt(index);
                      ToastHelper.success("Delete success");
                    });
                  } else {
                    ToastHelper.fail("Delete fail");
                  }
                });

                Navigator.of(context).pop(true);
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 100,
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == _items.length) {
            return _buildProgressIndicator();
          } else {
            final TrainingRecordModel item = _items[index];
            return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TrainingRecordDialog(
                        weight: item.weight.toDouble(),
                        reps: item.reps.toDouble(),
                        note: item.note,
                      );
                    },
                  ).then((result) {
                    if (result != false) {
                      TrainingRecordApi.patch(
                              item.id,
                              item.equip?.id.toInt() ?? 0,
                              result["weight"],
                              result["reps"],
                              result["note"])
                          .then((apiResult) {
                        if (apiResult) {
                          ToastHelper.success("Record updated");

                          resetList();
                        } else {
                          ToastHelper.fail("Failed to update record");
                        }
                      });
                    }
                  });
                },
                child: Dismissible(
                  key: Key(item.id.toString()),
                  confirmDismiss: (DismissDirection direction) async {
                    showDeleteAlertDialog(context, item, index);
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  child: Center(
                      child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: VizorFrame(
                        lineStroke: 2,
                        cornerStroke: 6,
                        lineColor: Color(0xFFFDFDFD),
                        color: Color(0xFF101010),
                        child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Expanded(
                                    child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      "EQUIP",
                                      style: TextStyle(
                                          color: Color(0xFF9F9F9F),
                                          fontWeight: FontWeight.bold),
                                    )),
                                    Expanded(
                                        child: Text(item.equip?.name ?? "-",
                                            style: TextStyle(
                                                color: Color(0xFF9F9F9F)))),
                                  ],
                                )),
                                Expanded(
                                    child: Row(
                                  children: [
                                    Expanded(
                                        child: Text("WEIGHT",
                                            style: TextStyle(
                                                color: Color(0xFF9F9F9F),
                                                fontWeight: FontWeight.bold))),
                                    Expanded(
                                        child: Text(item.weight.toString(),
                                            style: TextStyle(
                                                color: Color(0xFF9F9F9F)))),
                                  ],
                                )),
                                Expanded(
                                    child: Row(
                                  children: [
                                    Expanded(
                                        child: Text("REPS",
                                            style: TextStyle(
                                                color: Color(0xFF9F9F9F),
                                                fontWeight: FontWeight.bold))),
                                    Expanded(
                                        child: Text(item.reps.toString(),
                                            style: TextStyle(
                                                color: Color(0xFF9F9F9F)))),
                                  ],
                                )),
                                Expanded(
                                    child: Row(
                                  children: [
                                    Expanded(
                                        child: Text("NOTE",
                                            style: TextStyle(
                                                color: Color(0xFF9F9F9F)))),
                                    Expanded(
                                        child: Text(item.note.toString(),
                                            style: TextStyle(
                                                color: Color(0xFF9F9F9F)))),
                                  ],
                                )),
                              ],
                            ))),
                  )),
                ));
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
