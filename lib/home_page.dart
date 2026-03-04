import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_tamer/Auth/supa_auth_class.dart';
import 'package:task_tamer/landing.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final SupabaseClient client = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavStateCubit(),
      child: BlocBuilder<NavStateCubit, int>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text('Task Tamer')),
            body: <Widget>[
              //TODO agregar paginas
              Text('Home'),
              Text('Stats'),
              Text('Groups'),
              Text('Settings'),
            ][state],
            bottomNavigationBar: NavigationBar(
              selectedIndex: state,
              onDestinationSelected: (value) {
                context.read<NavStateCubit>().changeIndex(value);
              },
              destinations: [
                NavigationDestination(icon: Icon(Icons.home), label: 'home'),
                NavigationDestination(
                  icon: Icon(Icons.query_stats),
                  label: 'stats',
                ),
                NavigationDestination(
                  icon: Icon(Icons.groups),
                  label: 'groups',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings),
                  label: 'settings',
                ),
              ],
            ),
          );
        },
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

class NavStateCubit extends Cubit<int> {
  NavStateCubit() : super(0);
  void changeIndex(int index) {
    emit(index);
  }
}
