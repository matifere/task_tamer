import 'package:flutter/material.dart';
import 'package:task_tamer/Auth/supa_auth_class.dart';
import 'package:task_tamer/landing.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(children: [logOut(context)])),
    );
  }

  FilledButton logOut(BuildContext context) {
    return FilledButton(
      onPressed: () async {
        String res = await SupaAuthClass().logOut();
        if (res != 'Ok') {
          if (!context.mounted) {
            return;
          }
          ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              content: Text(res),
              actions: [
                FilledButton(
                  onPressed: () =>
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                  child: Text('Ok'),
                ),
              ],
            ),
          );
        } else {
          if (!context.mounted) {
            return;
          }
          Navigator.of(
            context,
          ).pushReplacement(MaterialPageRoute(builder: (context) => Landing()));
        }
      },
      child: Text('Log out'),
    );
  }
}
