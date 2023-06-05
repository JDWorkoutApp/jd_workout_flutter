import 'package:animated_glitch/animated_glitch.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vizor/components/atoms/vizor_button.dart';
import 'package:vizor/components/atoms/vizor_frame.dart';
import 'package:workout_app/api/equip_api.dart';
import 'package:workout_app/dialog/equip_dialog.dart';
import 'package:workout_app/utils/toast_helper.dart';

import '../models/equip_summary_model.dart';

class EquipListSliver extends StatefulWidget {
  const EquipListSliver({Key? key}) : super(key: key);

  @override
  EquipListSliverState createState() => EquipListSliverState();
}

class EquipListSliverState extends State<EquipListSliver> {
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

  Future<void> uploadImage(equipId) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }

    if (context.mounted) {
      CroppedFile? croppedFile = await ImageCropper()
          .cropImage(sourcePath: image.path, aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ], uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop',
            cropGridColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(title: 'Crop'),
        WebUiSettings(
          context: context,
        ),
      ]);

      if (croppedFile == null) {
        return;
      }

      EquipApi.uploadImage(equipId, croppedFile).then((value) {
        if (value) {
          ToastHelper.success("Upload success");
        } else {
          ToastHelper.fail("Upload fail");
        }
      });
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

  void showDeleteAlertDialog(BuildContext context, item, int index) {
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
              EquipApi.delete(item.equip.id).then((value) {
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
        itemExtent: 200,
        delegate: SliverChildBuilderDelegate(
          (context, index) {
          if (index == _items.length) {
            return _buildProgressIndicator();
          } else {
            final item = _items[index];
            final equipImageIndex = index % _equipImageList.length;
            return Dismissible(
              key: Key(item.equip.id.toString()),
              confirmDismiss: (DismissDirection direction) async {
                showDeleteAlertDialog(context, item, index);
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
                              child: GestureDetector(
                                onTap: () {
                                  uploadImage(item.equip.id);
                                },
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
                              ))
                              ),
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
                                      label: Text("EDIT"),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return EquipDialog(
                                              name: item.equip.name,
                                              note: item.equip.note,
                                            );
                                          },
                                        ).then((result) {
                                          if (result != false) {
                                            EquipApi.patch(
                                                    item.equip.id,
                                                    result['name'],
                                                    result['note'])
                                                .then((apiResult) {
                                              if (apiResult) {
                                                ToastHelper.success(
                                                    "Equip updated");

                                                resetList();
                                              } else {
                                                ToastHelper.fail(
                                                    "Failed to update equip");
                                              }
                                            });
                                          }
                                        });
                                      }),
                                  VizorButton(
                                      label: Text("WEIGHT"), onPressed: () {}),
                                  VizorButton(
                                      label: Text("DELETE"), onPressed: () {
                                        showDeleteAlertDialog(context, item, index);
                                  }),
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
