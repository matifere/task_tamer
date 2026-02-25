import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_tamer/Auth/supa_auth_class.dart';
import 'package:task_tamer/landing.dart';
/*
Obvio que esto es un ejemplo solo para probar que Supabase esta cargando bien los usuarios

DATO IMPORTANTE: Es una buena practica (y estaria bueno usarlo aca) el tema de crear tablas con RLS,
                Lo unico que hay que hacer es crear politicas en donde el CRUD detecte el usuario para confirmar
                lo que puede leer y lo que no.
                por defecto en supabase ya esta activado el RLS asi que solo queda poner las politicas
*/

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final SupabaseClient client = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quota'),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu_rounded)),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Text(
              client.auth.currentUser!.email ?? '',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            FilledButton(
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
                          onPressed: () => ScaffoldMessenger.of(
                            context,
                          ).hideCurrentMaterialBanner(),
                          child: Text('Ok'),
                        ),
                      ],
                    ),
                  );
                } else {
                  if (!context.mounted) {
                    return;
                  }
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Landing()),
                  );
                }
              },
              child: Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
