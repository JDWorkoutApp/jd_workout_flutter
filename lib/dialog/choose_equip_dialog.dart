import 'package:flutter/material.dart';
import 'package:workout_app/api/equip_api.dart';
import 'package:workout_app/models/equip_summary_model.dart';

class ChooseEquipDialog extends StatefulWidget {
  ChooseEquipDialog({Key? key}) : super(key: key);

  _ChooseEquipDialogState createState() => _ChooseEquipDialogState();
}

class _ChooseEquipDialogState extends State<ChooseEquipDialog> {
  final ScrollController _scrollController = ScrollController();
  List<EquipSummaryModel> equipList = [];

  bool _isLoading = false;
  int page = 1;

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

    var result = await EquipApi.get(page);

    List<EquipSummaryModel> items = result.equipSummaries;

    setState(() {
      equipList.addAll(items);
      _isLoading = true;
      page++;
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
            String formattedDaysDifference = "";
            if (equipList[index].lastUsed != null) {
              DateTime now = DateTime.now();
              DateTime? lastUsed = equipList[index].lastUsed;
              Duration difference = now.difference(lastUsed!);
              double daysDifference = difference.inMinutes.toDouble() / 60 / 24;
              formattedDaysDifference = daysDifference.toStringAsFixed(2);
            }

            return InkWell(
              onTap: () {
                Navigator.of(context).pop(equipList[index]);
              },
              child: Row(
                children: [
                  equipList[index].equip.image != null ? Image.network(
                    equipList[index].equip.image ?? "",
                    width: 50,
                    height: 50,
                  ) : SizedBox(width: 50, height: 50),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(equipList[index].equip.name),
                      Text(equipList[index].equip.note),
                      equipList[index].lastUsed != null ? Text(
                        formattedDaysDifference + " days ago",
                      ) : SizedBox(),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}