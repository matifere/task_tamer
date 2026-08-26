import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  final SupabaseClient _supabaseClient;

  CreateTaskCubit({SupabaseClient? supabaseClient})
      : _supabaseClient = supabaseClient ?? Supabase.instance.client,
        super(CreateTaskInitial());

  Future<void> createTask({
    required String groupId,
    required String titulo,
    required String descripcion,
    required bool esReutilizable,
    required String frecuenciaReinicio,
    required double multiplicadorDificultad,
  }) async {
    if (titulo.trim().isEmpty) {
      emit(const CreateTaskFailure("El título no puede estar vacío"));
      return;
    }

    emit(CreateTaskLoading());

    try {
      await _supabaseClient.from('tasks').insert({
        'group_id': groupId,
        'titulo': titulo.trim(),
        'descripcion': descripcion.trim(),
        'es_reutilizable': esReutilizable,
        'frecuencia_reinicio': frecuenciaReinicio,
        'multiplicador_dificultad': multiplicadorDificultad,
      });

      emit(CreateTaskSuccess());
    } catch (e) {
      emit(CreateTaskFailure(e.toString()));
    }
  }
}
