import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tamer/theme/theme.dart';
import 'cubit/navigation_cubit.dart';
import 'tasks_page.dart';
import 'ranking_page.dart';
import 'rewards_page.dart';
import 'settings_page.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  final List<Widget> _pages = const [
    TasksPage(),
    RankingPage(),
    RewardsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          
          return Scaffold(
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

    final items = [
      _NavItem(icon: Icons.task_alt_rounded, label: 'Tareas', activeColor: candyColors.candyPink),
      _NavItem(icon: Icons.leaderboard_rounded, label: 'Ranking', activeColor: candyColors.vibrantTurquoise),
      _NavItem(icon: Icons.card_giftcard_rounded, label: 'Premios', activeColor: candyColors.sunnyYellow),
      _NavItem(icon: Icons.settings_rounded, label: 'Ajustes', activeColor: candyColors.limeGreen),
    ];

    return Container(
      margin: const EdgeInsets.all(AppSpacing.marginMobile),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.base),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: AppRadius.circularXl,
        boxShadow: AppShadows.candyShadow(theme.colorScheme.onSurface.withOpacity(0.05)),
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
                  color: isSelected ? item.activeColor.withOpacity(0.15) : Colors.transparent,
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
