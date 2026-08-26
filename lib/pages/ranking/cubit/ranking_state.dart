abstract class RankingState {}

class RankingInitial extends RankingState {}

class RankingLoading extends RankingState {}

class RankingLoaded extends RankingState {
  final List<Map<String, dynamic>> ranking;
  final List<Map<String, dynamic>> weeklyProgress;
  
  RankingLoaded({
    required this.ranking,
    required this.weeklyProgress,
  });
}

class RankingError extends RankingState {
  final String message;
  RankingError(this.message);
}
