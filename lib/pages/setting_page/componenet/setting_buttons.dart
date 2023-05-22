import 'package:flutter/material.dart';
import 'package:workout_app/pages/setting_page/componenet/logout_button.dart';
import 'package:workout_app/pages/setting_page/componenet/reset-password-button.dart';

class SettingButtons extends StatelessWidget {
  const SettingButtons();

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      ResetPasswordButton(),
      LogoutButton(),
    ];

    return Column(children: [
      Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return items[index];
              },
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: ScrollPhysics(),
            ),
        ),
    ]);
  }
}
