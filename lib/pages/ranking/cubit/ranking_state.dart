abstract class RankingState {}

class RankingInitial extends RankingState {}

class RankingLoading extends RankingState {}

class RankingLoaded extends RankingState {
  final List<Map<String, dynamic>> ranking;
  RankingLoaded(this.ranking);
}

class RankingError extends RankingState {
  final String message;
  RankingError(this.message);
}
