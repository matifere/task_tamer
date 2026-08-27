abstract class RewardsState {}

class RewardsInitial extends RewardsState {}
class RewardsLoading extends RewardsState {}
class RewardsLoaded extends RewardsState {
  final int globalCoins;
  final List<String> purchasedCosmetics;
  final String equippedStyle;

  RewardsLoaded({
    required this.globalCoins,
    required this.purchasedCosmetics,
    required this.equippedStyle,
  });
}
class RewardsError extends RewardsState {
  final String message;
  RewardsError(this.message);
}
