import 'package:flutter/material.dart';
import 'package:workout_app/api/equip_api.dart';
import 'package:workout_app/dialog/equip_dialog.dart';
import 'package:workout_app/dialog/equip_weights_dialog.dart';
import 'package:workout_app/models/equip_model.dart';
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
              child: ListTile(
                title: Text(item.equip.name),
                subtitle: Text(item.equip.note),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => EquipWeightDialog(weights: item.equip.weights)
                        ).then((result) {
                          if (result != false) {
                            EquipApi.putWeight(item.equip.id, result)
                                .then((apiResult) {
                              if (apiResult) {
                                ToastHelper.success("Added");
                              } else {
                                ToastHelper.fail("Failed to add");
                              }
                            });
                          }
                        });
                      },
                    ),
                    IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EquipDialog(name: item.equip.name, note: item.equip.note);
                      },
                    ).then((result) {
                      if (result != false) {
                        EquipApi.patch(item.equip.id, result['name'], result['note'])
                            .then((apiResult) {
                          if (apiResult) {
                            ToastHelper.success("Updated");
                          } else {
                            ToastHelper.fail("Failed to update");
                          }
                        });
                      }
                    });
                  })
                ],
                ),
              ),
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
