import 'package:flutter/material.dart';

class Item {
  final String name;
  final String note;

  Item({required this.name, required this.note});
}

class EquipList extends StatefulWidget {
  const EquipList({Key? key}) : super(key: key);

  @override
  _EquipListState createState() => _EquipListState();
}

class _EquipListState extends State<EquipList> {
  final ScrollController _scrollController = ScrollController();
  List<Item> _items = List.generate(50, (index) => Item(name: 'Item $index', note: 'Note $index'));

  bool _isLoading = false;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMoreItems();
    }
  }

  void _loadMoreItems() {
    if (_isLoading) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate a delay while loading more items
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _items.addAll(List.generate(50, (index) => Item(name: 'Item ${_items.length + index}', note: 'Note ${_items.length + index}')));
        _page++;
        _isLoading = false;
      });
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
            return ListTile(
              title: Text(item.name),
              subtitle: Text(item.note),
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