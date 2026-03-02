import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_tamer/Auth/supa_auth_class.dart';
import 'package:task_tamer/landing.dart';
import 'package:task_tamer/ollamaServ/ollama_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final SupabaseClient client = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Tamer'),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu_rounded)),
      ),
      body: Center(
        child: FutureBuilder(
          future: OllamaService().obtenerRespuesta("hola? tu sabes mi nombre?"),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.data == null) {
              return CircularProgressIndicator();
            }
            return Text(asyncSnapshot.data ?? '');
          },
        ),
      ),
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

class TopContainer extends StatelessWidget {
  const TopContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.width * 0.3,
        child: Card(),
      ),
    );
  }
}
