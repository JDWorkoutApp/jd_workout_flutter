import 'package:flutter/material.dart';
import 'package:workout_app/models/equip_model.dart';

class ChooseEquipDialog extends StatefulWidget {
  ChooseEquipDialog({Key? key}) : super(key: key);

  _ChooseEquipDialogState createState() => _ChooseEquipDialogState();
}

class _ChooseEquipDialogState extends State<ChooseEquipDialog> {
  final ScrollController _scrollController = ScrollController();
  List<EquipModel> equipList = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _getEquipList();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _getEquipList();
    }
  }

  void _getEquipList() async {
    if (_isLoading) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    setState(() {
      _isLoading = false;

      equipList.addAll([
        EquipModel(
          id: 1,
          name: 'Dumbbell',
          note: 'Dumbbell note',
        ),
        EquipModel(
          id: 2,
          name: 'Barbell',
          note: 'Barbell note',
        ),
        EquipModel(
          id: 3,
          name: 'Kettlebell',
          note: 'Kettlebell note',
        ),
        EquipModel(
          id: 1,
          name: 'Dumbbell',
          note: 'Dumbbell note',
        ),
        EquipModel(
          id: 2,
          name: 'Barbell',
          note: 'Barbell note',
        ),
        EquipModel(
          id: 3,
          name: 'Kettlebell',
          note: 'Kettlebell note',
        ),
        EquipModel(
          id: 1,
          name: 'Dumbbell',
          note: 'Dumbbell note',
        ),
        EquipModel(
          id: 2,
          name: 'Barbell',
          note: 'Barbell note',
        ),
        EquipModel(
          id: 3,
          name: 'Kettlebell',
          note: 'Kettlebell note',
        ),
        EquipModel(
          id: 1,
          name: 'Dumbbell',
          note: 'Dumbbell note',
        ),
        EquipModel(
          id: 2,
          name: 'Barbell',
          note: 'Barbell note',
        ),
        EquipModel(
          id: 3,
          name: 'Kettlebell',
          note: 'Kettlebell note',
        ),
        EquipModel(
          id: 1,
          name: 'Dumbbell',
          note: 'Dumbbell note',
        ),
        EquipModel(
          id: 2,
          name: 'Barbell',
          note: 'Barbell note',
        ),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Choose Equipment"),
      content: Container(
        width: double.maxFinite,
        height: 200,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: equipList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).pop(equipList[index]);
              },
              child: ListTile(
                title: Text(equipList[index].name),
                subtitle: Text(equipList[index].note),
              ),
            );
          },
        ),
      ),
    );
  }
}
