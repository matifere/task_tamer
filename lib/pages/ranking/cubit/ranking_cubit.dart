import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ranking_state.dart';

class RankingCubit extends Cubit<RankingState> {
  final SupabaseClient _supabaseClient;
  final String groupId;

  RankingCubit({
    required this.groupId,
    SupabaseClient? supabaseClient,
  })  : _supabaseClient = supabaseClient ?? Supabase.instance.client,
        super(RankingInitial());

  Future<void> loadRanking() async {
    emit(RankingLoading());
    try {
      final response = await _supabaseClient
          .rpc('get_group_ranking', params: {'p_group_id': groupId});
          
      final rankingList = List<Map<String, dynamic>>.from(response);
      emit(RankingLoaded(rankingList));
    } catch (e) {
      emit(RankingError(e.toString()));
    }
  }
}
