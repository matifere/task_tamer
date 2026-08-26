import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final SupabaseClient _supabaseClient;
  final String groupId;

  TasksCubit({
    required this.groupId,
    SupabaseClient? supabaseClient,
  })  : _supabaseClient = supabaseClient ?? Supabase.instance.client,
        super(TasksInitial());

  Future<void> loadTasks() async {
    emit(TasksLoading());
    try {
      final response = await _supabaseClient
          .rpc('get_pending_tasks', params: {'p_group_id': groupId});

      final tasks = List<Map<String, dynamic>>.from(response);
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }
}
