import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tamer/theme/theme.dart';
import 'package:task_tamer/l10n/app_localizations.dart';
import 'cubit/navigation_cubit.dart';
import 'tasks_page.dart';
import 'tasks/cubit/tasks_cubit.dart';
import 'ranking_page.dart';
import 'ranking/cubit/ranking_cubit.dart';
import 'rewards_page.dart';
import 'settings_page.dart';

class MainLayout extends StatelessWidget {
  final String groupId;
  final String groupCode;

  const MainLayout({
    super.key,
    required this.groupId,
    required this.groupCode,
  });

  List<Widget> get _pages => [
        TasksPage(groupId: groupId, groupCode: groupCode),
        RankingPage(groupId: groupId),
        const RewardsPage(),
        const SettingsPage(),
      ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(create: (_) => TasksCubit(groupId: groupId, groupCode: groupCode)..loadTasks()),
        BlocProvider(create: (_) => RankingCubit(groupId: groupId)..loadRanking()),
      ],
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          final l10n = AppLocalizations.of(context)!;
          
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              elevation: 0,
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.task_alt_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.appTitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _pages[currentIndex],
            ),
            bottomNavigationBar: CandyBottomNav(
              currentIndex: currentIndex,
              onTap: (index) => context.read<NavigationCubit>().setTab(index),
            ),
          );
        },
      ),
    );
  }
}

class CandyBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CandyBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final candyColors = theme.extension<CandyColors>()!;
    final l10n = AppLocalizations.of(context)!;

    final items = [
      _NavItem(icon: Icons.task_alt_rounded, label: l10n.tasks, activeColor: candyColors.candyPink),
      _NavItem(icon: Icons.leaderboard_rounded, label: l10n.ranking, activeColor: candyColors.vibrantTurquoise),
      _NavItem(icon: Icons.card_giftcard_rounded, label: l10n.rewards, activeColor: candyColors.sunnyYellow),
      _NavItem(icon: Icons.settings_rounded, label: l10n.settings, activeColor: candyColors.limeGreen),
    ];

    return Container(
      margin: const EdgeInsets.all(AppSpacing.marginMobile),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.base),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: AppRadius.circularXl,
        boxShadow: AppShadows.candyShadow(theme.colorScheme.onSurface.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = currentIndex == index;

          return Flexible(
            flex: isSelected ? 1 : 0,
            child: GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutQuart,
                padding: EdgeInsets.symmetric(
                  horizontal: isSelected ? AppSpacing.md : AppSpacing.sm,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? item.activeColor.withValues(alpha: 0.15) : Colors.transparent,
                  borderRadius: AppRadius.circularFull,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.icon,
                      color: isSelected ? item.activeColor : theme.colorScheme.onSurfaceVariant,
                      size: 24,
                    ),
                    if (isSelected)
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: AppSpacing.xs),
                          child: Text(
                            item.label,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: item.activeColor,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final Color activeColor;

  _NavItem({
    required this.icon,
    required this.label,
    required this.activeColor,
  });
}
