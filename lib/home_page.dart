import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_tamer/Auth/supa_auth_class.dart';
import 'package:task_tamer/InHome/groups_page.dart';
import 'package:task_tamer/InHome/settings_page.dart';
import 'package:task_tamer/InHome/stats_page.dart';
import 'package:task_tamer/landing.dart';
import 'package:task_tamer/InHome/tasks_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final SupabaseClient client = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavStateCubit(),
      child: BlocBuilder<NavStateCubit, int>(
        builder: (context, state) {
          // Obtenemos la referencia al Cubit actual
          final navCubit = context.read<NavStateCubit>();

          return Scaffold(
            appBar: AppBar(title: const Text('Task Tamer')),
            body: PageView(
              // Conectamos el controlador alojado en el Cubit
              controller: navCubit.pageController,
              // Desactivamos el deslizamiento táctil para mantener la sincronización simple por ahora
              physics: const NeverScrollableScrollPhysics(),
              children: [
                TasksPage(),
                StatsPage(),
                GroupsPage(),
                SettingsPage(),
              ],
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: state,
              onDestinationSelected: (value) {
                // Al tocar un ícono, el Cubit se encarga de la animación y del estado
                navCubit.changeIndex(value);
              },
              destinations: const [
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
}

class NavStateCubit extends Cubit<int> {
  NavStateCubit() : super(0);

  final PageController pageController = PageController();

  void changeIndex(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.decelerate,
    );
    emit(index);
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
