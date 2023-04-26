import 'package:flutter/material.dart';
import 'package:workout_app/api/training_record_api.dart';
import 'package:workout_app/models/training_model.dart';

class ExerciseList extends StatefulWidget {
  const ExerciseList({Key? key}) : super(key: key);

  @override
  _ExerciseListState createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  final ScrollController _scrollController = ScrollController();
  List<TrainingModel> _items = [];
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

    var result = await TrainingRecordApi.get(_page);

    setState(() {
      _items.addAll(result.trainings);
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
              key: Key(index.toString()),
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
                title: Text("test"),
                subtitle: Text("teaoue"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
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
