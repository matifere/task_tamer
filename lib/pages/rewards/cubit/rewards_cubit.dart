import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'rewards_state.dart';

class RewardsCubit extends Cubit<RewardsState> {
  final SupabaseClient _supabaseClient;

  RewardsCubit({SupabaseClient? supabaseClient})
      : _supabaseClient = supabaseClient ?? Supabase.instance.client,
        super(RewardsInitial());

  Future<void> loadUserRewards() async {
    emit(RewardsLoading());
    try {
      final userId = _supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('No user logged in');

      final response = await _supabaseClient
          .from('users')
          .select('monedas_globales, purchased_cosmetics, equipped_name_style')
          .eq('id', userId)
          .single();

      final coins = (response['monedas_globales'] as num?)?.toInt() ?? 0;
      final purchased = List<String>.from(response['purchased_cosmetics'] ?? ['default']);
      final equipped = response['equipped_name_style'] as String? ?? 'default';

      emit(RewardsLoaded(
        globalCoins: coins,
        purchasedCosmetics: purchased,
        equippedStyle: equipped,
      ));
    } catch (e) {
      emit(RewardsError(e.toString()));
    }
  }

  Future<void> buyCosmetic(String cosmeticId, int cost) async {
    try {
      final userId = _supabaseClient.auth.currentUser?.id;
      if (userId == null) return;
      
      final result = await _supabaseClient.rpc('buy_cosmetic', params: {
        'p_user_id': userId,
        'p_cosmetic_id': cosmeticId,
        'p_cost': cost,
      });

      if (result == true) {
        // Reload
        await loadUserRewards();
      } else {
        emit(RewardsError("insufficientCoins"));
      }
    } catch (e) {
      emit(RewardsError(e.toString()));
    }
  }

  Future<void> equipCosmetic(String cosmeticId) async {
    try {
      final userId = _supabaseClient.auth.currentUser?.id;
      if (userId == null) return;

      await _supabaseClient.rpc('equip_cosmetic', params: {
        'p_user_id': userId,
        'p_cosmetic_id': cosmeticId,
      });

      await loadUserRewards();
    } catch (e) {
      emit(RewardsError(e.toString()));
    }
  }
}
