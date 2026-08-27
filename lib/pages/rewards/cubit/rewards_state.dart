abstract class RewardsState {}

class RewardsInitial extends RewardsState {}
class RewardsLoading extends RewardsState {}
class RewardsLoaded extends RewardsState {
  final int globalCoins;
  final List<String> purchasedCosmetics;
  final String equippedStyle;
  final String equippedAvatar;

  RewardsLoaded({
    required this.globalCoins,
    required this.purchasedCosmetics,
    required this.equippedStyle,
    required this.equippedAvatar,
  });
}
class RewardsError extends RewardsState {
  final String message;
  RewardsError(this.message);
}
