import 'package:animated_glitch/animated_glitch.dart';
import 'package:flutter/material.dart';
import 'package:vizor/components/atoms/vizor_button.dart';
import 'package:vizor/components/atoms/vizor_frame.dart';
import 'package:workout_app/api/equip_api.dart';
import 'package:workout_app/utils/toast_helper.dart';

import '../models/equip_summary_model.dart';

class EquipList extends StatefulWidget {
  const EquipList({Key? key}) : super(key: key);

  @override
  EquipListState createState() => EquipListState();
}

class EquipListState extends State<EquipList> {
  final ScrollController _scrollController = ScrollController();
  List<EquipSummaryModel> _items = [];
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

    var result = await EquipApi.get(_page);

    List<EquipSummaryModel> items = result.equipSummaries;

    setState(() {
      _items.addAll(items);
      _page++;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _items.length + 1,
        itemBuilder: (context, index) {
          if (index == _items.length) {
            return _buildProgressIndicator();
          } else {
            final item = _items[index];
            final equipImageIndex = index % _equipImageList.length;
            return Dismissible(
              key: Key(item.equip.id.toString()),
              confirmDismiss: (DismissDirection direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Delte'),
                      content: Text('Make sure to delete?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text('cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text('confirm'),
                        ),
                      ],
                    );
                  },
                );
              },
              onDismissed: (direction) {
                EquipApi.delete(item.equip.id).then((value) => {
                      if (value)
                        {
                          setState(() {
                            _items.removeAt(index);
                            ToastHelper.success("delete success");
                          })
                        }
                      else
                        {ToastHelper.fail("delete fail")}
                    });
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
              child: Center(
                  child: Container(
                height: 200,
                padding: new EdgeInsets.all(10.0),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Theme.of(context).primaryColorLight,
                    elevation: 10,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: VizorFrame(
                                  child: Container(
                                height: 100,
                                child: AnimatedGlitch(
                                    controller: AnimatedGlitchController(
                                      chance: 35,
                                      frequency:
                                          const Duration(milliseconds: 200),
                                      level: 1.2,
                                      distortionShift:
                                          const DistortionShift(count: 3),
                                    ),
                                    child: Image.asset(
                                      _equipImageList[equipImageIndex],
                                      fit: BoxFit.cover,
                                    )),
                              )),
                            )),
                        Expanded(
                          flex: 8,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: Text(item.equip.name,
                                    style: TextStyle(fontSize: 30.0)),
                                subtitle: Text(item.equip.note,
                                    style: TextStyle(fontSize: 18.0)),
                              ),
                              ButtonBar(
                                children: <Widget>[
                                  VizorButton(
                                      label: Text("EDIT"), onPressed: () {}),
                                  VizorButton(
                                      label: Text("WEIGHT"), onPressed: () {}),
                                  VizorButton(
                                      label: Text("DELETE"), onPressed: () {}),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              )),
            );
          }
        },
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
