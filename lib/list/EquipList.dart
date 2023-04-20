import 'package:flutter/material.dart';
import 'package:workout_app/api/equip_api.dart';
import 'package:workout_app/utils/toast_helper.dart';

class Item {
  final int id;
  final String name;
  final String note;

  Item({required this.id, required this.name, required this.note});
}

class EquipList extends StatefulWidget {
  const EquipList({Key? key}) : super(key: key);

  @override
  _EquipListState createState() => _EquipListState();
}

class _EquipListState extends State<EquipList> {
  final ScrollController _scrollController = ScrollController();
  List<Item> _items = [];
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

    List<Item> items = result['data']
        .map<Item>((item) =>
            Item(id: item['id'], name: item['name'], note: item['note']))
        .toList();

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
              key: Key(item.id.toString()),
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
                EquipApi.delete(item.id).then((value) => {
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
                title: Text(item.name),
                subtitle: Text(item.note),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // TODO
                  },
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
