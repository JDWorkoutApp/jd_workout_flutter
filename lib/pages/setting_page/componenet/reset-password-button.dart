import 'package:flutter/material.dart';
import 'package:workout_app/pages/reset_password_page/reset_password_page.dart';

class ResetPasswordButton extends StatelessWidget {
  const ResetPasswordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: ListTile(
        leading: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(Icons.lock),
        ),
        title: Text(
          "Reset password",
          style: TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          "press to reset password",
          style: Theme.of(context).textTheme.bodyMedium!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(Icons.navigate_next),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResetPasswordPage(),
              ));
        },
      ),
    );
  }
}
