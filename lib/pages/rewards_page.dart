import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tamer/l10n/app_localizations.dart';
import 'rewards/cubit/rewards_cubit.dart';
import 'rewards/cubit/rewards_state.dart';
import 'rewards/widgets/cosmetic_name_text.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RewardsCubit()..loadUserRewards(),
      child: const _RewardsView(),
    );
  }
}

class _RewardsView extends StatelessWidget {
  const _RewardsView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    // Catálogo de cosméticos fijo
    final List<Map<String, dynamic>> catalog = [
      {'id': 'default', 'name': l10n.cosmeticDefaultName, 'desc': l10n.cosmeticDefaultDesc, 'cost': 0},
      {'id': 'gold', 'name': l10n.cosmeticGoldName, 'desc': l10n.cosmeticGoldDesc, 'cost': 500},
      {'id': 'hacker', 'name': l10n.cosmeticHackerName, 'desc': l10n.cosmeticHackerDesc, 'cost': 600},
      {'id': 'neon', 'name': l10n.cosmeticNeonName, 'desc': l10n.cosmeticNeonDesc, 'cost': 800},
      {'id': 'fire', 'name': l10n.cosmeticFireName, 'desc': l10n.cosmeticFireDesc, 'cost': 1000},
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocConsumer<RewardsCubit, RewardsState>(
        listener: (context, state) {
          if (state is RewardsError) {
            final l10n = AppLocalizations.of(context)!;
            String message = state.message;
            if (message == 'insufficientCoins') {
              message = l10n.insufficientCoins;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), backgroundColor: colorScheme.error),
            );
          }
        },
        builder: (context, state) {
          if (state is RewardsLoading || state is RewardsInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is RewardsLoaded) {
            return Column(
              children: [
                // Header de Monedas Globales
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.stars_rounded, color: Colors.amber.shade600, size: 32),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.myGlobalCoins,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            "${state.globalCoins} 🪙",
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.amber.shade700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: catalog.length,
                    itemBuilder: (context, index) {
                      final item = catalog[index];
                      final isOwned = state.purchasedCosmetics.contains(item['id']);
                      final isEquipped = state.equippedStyle == item['id'];
                      
                      return Card(
                        elevation: isEquipped ? 4 : 0,
                        margin: const EdgeInsets.only(bottom: 12),
                        color: isEquipped 
                            ? colorScheme.primaryContainer.withValues(alpha: 0.3)
                            : colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isEquipped ? colorScheme.primary : colorScheme.outlineVariant.withValues(alpha: 0.3),
                            width: isEquipped ? 2 : 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: colorScheme.surfaceContainerHighest,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: CosmeticNameText(
                                    text: "A", // Preview
                                    styleId: item['id'],
                                    baseStyle: const TextStyle(fontSize: 24),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CosmeticNameText(
                                      text: item['name'],
                                      styleId: item['id'],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item['desc'],
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isEquipped)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: colorScheme.primary,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    l10n.equipped,
                                    style: TextStyle(
                                      color: colorScheme.onPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              else if (isOwned)
                                OutlinedButton(
                                  onPressed: () {
                                    context.read<RewardsCubit>().equipCosmetic(item['id']);
                                  },
                                  child: Text(l10n.equip),
                                )
                              else
                                FilledButton.icon(
                                  onPressed: () {
                                    context.read<RewardsCubit>().buyCosmetic(item['id'], item['cost']);
                                  },
                                  icon: const Icon(Icons.shopping_cart_checkout, size: 16),
                                  label: Text("${item['cost']}"),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: Colors.amber.shade600,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 100), // Espacio para el bottom nav
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
