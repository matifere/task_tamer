import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'active_task_state.dart';

class ActiveTaskCubit extends Cubit<ActiveTaskState> {
  final SupabaseClient _supabaseClient;

  ActiveTaskCubit({SupabaseClient? supabaseClient})
      : _supabaseClient = supabaseClient ?? Supabase.instance.client,
        super(ActiveTaskInitial());

  Future<void> completeTask({
    required String taskId,
    required String groupId,
    required int secondsElapsed,
    required double multiplier,
  }) async {
    emit(ActiveTaskLoading());
    try {
      final userId = _supabaseClient.auth.currentUser!.id;
      
      // Calculate duration in minutes (minimum 1)
      int durationMinutes = (secondsElapsed / 60).ceil();
      if (durationMinutes < 1) durationMinutes = 1;

      // Base coins: 10 per minute. Multiplied by difficulty.
      int baseCoins = durationMinutes * 10;
      int earnedCoins = (baseCoins * multiplier).round();

      // Call the RPC function we created
      await _supabaseClient.rpc('complete_task', params: {
        'p_task_id': taskId,
        'p_group_id': groupId,
        'p_user_id': userId,
        'p_duracion_minutos': durationMinutes,
        'p_monedas_ganadas': earnedCoins,
      });

      emit(ActiveTaskCompleted(earnedCoins));
    } catch (e) {
      emit(ActiveTaskError(e.toString()));
    }
  }
}
