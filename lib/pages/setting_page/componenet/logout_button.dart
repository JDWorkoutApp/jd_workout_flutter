import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/pages/login_page/login_page.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  void _logout(BuildContext context) async {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove("jwtToken");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: ListTile(
        leading: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(Icons.logout),
        ),
        title: Text(
          "Logout",
          style: TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          "press to logout",
          style: Theme.of(context).textTheme.bodyMedium!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(Icons.navigate_next),
        onTap: () {
          _logout(context);
        },
      ),
    );
  }
}
