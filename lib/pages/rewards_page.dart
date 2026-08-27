import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tamer/l10n/app_localizations.dart';
import 'rewards/cubit/rewards_cubit.dart';
import 'rewards/cubit/rewards_state.dart';
import 'rewards/widgets/cosmetic_name_text.dart';
import 'rewards/widgets/cosmetic_avatar.dart';

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

    final List<Map<String, dynamic>> nameCatalog = [
      {'id': 'default', 'name': l10n.cosmeticDefaultName, 'desc': l10n.cosmeticDefaultDesc, 'cost': 0, 'type': 'name'},
      {'id': 'hacker', 'name': l10n.cosmeticHackerName, 'desc': l10n.cosmeticHackerDesc, 'cost': 1500, 'type': 'name'},
      {'id': 'ocean', 'name': l10n.cosmeticOceanName, 'desc': l10n.cosmeticOceanDesc, 'cost': 2500, 'type': 'name'},
      {'id': 'bubblegum', 'name': l10n.cosmeticBubblegumName, 'desc': l10n.cosmeticBubblegumDesc, 'cost': 3500, 'type': 'name'},
      {'id': 'gold', 'name': l10n.cosmeticGoldName, 'desc': l10n.cosmeticGoldDesc, 'cost': 5000, 'type': 'name'},
      {'id': 'ice', 'name': l10n.cosmeticIceName, 'desc': l10n.cosmeticIceDesc, 'cost': 7500, 'type': 'name'},
      {'id': 'neon', 'name': l10n.cosmeticNeonName, 'desc': l10n.cosmeticNeonDesc, 'cost': 10000, 'type': 'name'},
      {'id': 'glitch', 'name': l10n.cosmeticGlitchName, 'desc': l10n.cosmeticGlitchDesc, 'cost': 15000, 'type': 'name'},
      {'id': 'fire', 'name': l10n.cosmeticFireName, 'desc': l10n.cosmeticFireDesc, 'cost': 20000, 'type': 'name'},
      {'id': 'rainbow', 'name': l10n.cosmeticRainbowName, 'desc': l10n.cosmeticRainbowDesc, 'cost': 30000, 'type': 'name'},
    ];

    final List<Map<String, dynamic>> avatarCatalog = [
      {'id': 'avatar_default', 'name': l10n.cosmeticDefaultName, 'desc': l10n.cosmeticDefaultDesc, 'cost': 0, 'type': 'avatar'},
      {'id': 'avatar_smile', 'name': l10n.avatarSmileName, 'desc': l10n.avatarSmileDesc, 'cost': 1500, 'type': 'avatar'},
      {'id': 'avatar_melting', 'name': l10n.avatarMeltingName, 'desc': l10n.avatarMeltingDesc, 'cost': 2500, 'type': 'avatar'},
      {'id': 'avatar_grimacing', 'name': l10n.avatarGrimacingName, 'desc': l10n.avatarGrimacingDesc, 'cost': 3500, 'type': 'avatar'},
      {'id': 'avatar_crying_loudly', 'name': l10n.avatarCryingName, 'desc': l10n.avatarCryingDesc, 'cost': 5000, 'type': 'avatar'},
      {'id': 'avatar_squinting_tongue', 'name': l10n.avatarTongueName, 'desc': l10n.avatarTongueDesc, 'cost': 7500, 'type': 'avatar'},
      {'id': 'avatar_turtle', 'name': l10n.avatarTurtleName, 'desc': l10n.avatarTurtleDesc, 'cost': 10000, 'type': 'avatar'},
      {'id': 'avatar_octopus', 'name': l10n.avatarOctopusName, 'desc': l10n.avatarOctopusDesc, 'cost': 15000, 'type': 'avatar'},
      {'id': 'avatar_hear_no_evil', 'name': l10n.avatarHearNoEvilName, 'desc': l10n.avatarHearNoEvilDesc, 'cost': 20000, 'type': 'avatar'},
      {'id': 'avatar_see_no_evil', 'name': l10n.avatarSeeNoEvilName, 'desc': l10n.avatarSeeNoEvilDesc, 'cost': 25000, 'type': 'avatar'},
      {'id': 'avatar_say_no_evil', 'name': l10n.avatarSayNoEvilName, 'desc': l10n.avatarSayNoEvilDesc, 'cost': 30000, 'type': 'avatar'},
      {'id': 'avatar_fire_emoji', 'name': l10n.avatarFireEmojiName, 'desc': l10n.avatarFireEmojiDesc, 'cost': 50000, 'type': 'avatar'},
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: TabBar(
          tabs: [
            Tab(text: l10n.tabNames, icon: const Icon(Icons.text_fields_rounded)),
            Tab(text: l10n.tabAvatars, icon: const Icon(Icons.face_retouching_natural_rounded)),
          ],
          labelColor: colorScheme.primary,
          unselectedLabelColor: colorScheme.onSurfaceVariant,
          indicatorColor: colorScheme.primary,
        ),
        body: BlocConsumer<RewardsCubit, RewardsState>(
          listener: (context, state) {
            if (state is RewardsError) {
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
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                    child: TabBarView(
                      children: [
                        _buildGrid(nameCatalog, state, context, theme, colorScheme, l10n),
                        _buildGrid(avatarCatalog, state, context, theme, colorScheme, l10n),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100), // Bottom nav spacing
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildGrid(
    List<Map<String, dynamic>> catalog, 
    RewardsLoaded state, 
    BuildContext context, 
    ThemeData theme, 
    ColorScheme colorScheme, 
    AppLocalizations l10n
  ) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: catalog.length,
      itemBuilder: (context, index) {
        final item = catalog[index];
        final isOwned = state.purchasedCosmetics.contains(item['id']);
        
        bool isEquipped = false;
        if (item['type'] == 'name') {
          isEquipped = state.equippedStyle == item['id'];
        } else if (item['type'] == 'avatar') {
          isEquipped = state.equippedAvatar == item['id'];
        }
        
        return Card(
          elevation: isEquipped ? 4 : 0,
          margin: EdgeInsets.zero,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Center(
                    child: item['type'] == 'name' 
                      ? CosmeticNameText(
                          text: "Aa",
                          styleId: item['id'],
                          baseStyle: const TextStyle(fontSize: 40),
                        )
                      : CosmeticAvatar(
                          avatarId: item['id'],
                          name: 'Aa',
                          radius: 36,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item['name'],
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: isEquipped
                        ? Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              l10n.equipped,
                              style: TextStyle(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          )
                        : isOwned
                          ? OutlinedButton(
                              onPressed: () {
                                context.read<RewardsCubit>().equipCosmetic(item['id']);
                              },
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 36),
                              ),
                              child: Text(l10n.equip),
                            )
                          : FilledButton.icon(
                              onPressed: () {
                                context.read<RewardsCubit>().buyCosmetic(item['id'], item['cost']);
                              },
                              icon: const Icon(Icons.shopping_cart_checkout, size: 14),
                              label: Text("${item['cost']}"),
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.amber.shade600,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 36),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
