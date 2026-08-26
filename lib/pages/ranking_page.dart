import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ranking/cubit/ranking_cubit.dart';
import 'ranking/cubit/ranking_state.dart';

class RankingPage extends StatelessWidget {
  final String groupId;

  const RankingPage({
    super.key,
    required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    return const _RankingView();
  }
}

class _RankingView extends StatelessWidget {
  const _RankingView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentUser = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<RankingCubit, RankingState>(
        builder: (context, state) {
          if (state is RankingLoading || state is RankingInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is RankingError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: colorScheme.error),
                  const SizedBox(height: 16),
                  Text(
                    "Error al cargar el ranking",
                    style: theme.textTheme.titleMedium?.copyWith(color: colorScheme.error),
                  ),
                  TextButton(
                    onPressed: () => context.read<RankingCubit>().loadRanking(),
                    child: const Text("Reintentar"),
                  )
                ],
              ),
            );
          }

          if (state is RankingLoaded) {
            final ranking = state.ranking;

            if (ranking.isEmpty) {
              return const Center(child: Text("No hay miembros en el grupo."));
            }

            return RefreshIndicator(
              onRefresh: () => context.read<RankingCubit>().loadRanking(),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 16, bottom: 120, left: 16, right: 16),
                itemCount: ranking.length,
                itemBuilder: (context, index) {
                  final user = ranking[index];
                  final isMe = user['user_id'] == currentUser?.id;
                  
                  return _RankItem(
                    index: index,
                    name: user['nombre'] ?? 'Sin nombre',
                    monedasHistoricas: user['monedas_historicas'] ?? 0,
                    isMe: isMe,
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _RankItem extends StatelessWidget {
  final int index;
  final String name;
  final int monedasHistoricas;
  final bool isMe;

  const _RankItem({
    required this.index,
    required this.name,
    required this.monedasHistoricas,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Widget rankWidget;
    if (index == 0) {
      rankWidget = const Icon(Icons.emoji_events, color: Colors.amber, size: 32);
    } else if (index == 1) {
      rankWidget = Icon(Icons.emoji_events, color: Colors.grey.shade400, size: 32);
    } else if (index == 2) {
      rankWidget = const Icon(Icons.emoji_events, color: Color(0xFFCD7F32), size: 32); // Bronze
    } else {
      rankWidget = SizedBox(
        width: 32,
        child: Center(
          child: Text(
            '#${index + 1}',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: isMe ? 4 : 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: isMe 
            ? BorderSide(color: colorScheme.primary, width: 2)
            : BorderSide.none,
      ),
      color: isMe ? colorScheme.primaryContainer.withValues(alpha: 0.3) : colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            rankWidget,
            const SizedBox(width: 16),
            CircleAvatar(
              backgroundColor: colorScheme.secondaryContainer,
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: TextStyle(
                  color: colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: isMe ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  if (isMe)
                    Text(
                      "Tú",
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.monetization_on_rounded, size: 18, color: Colors.amber.shade700),
                  const SizedBox(width: 4),
                  Text(
                    monedasHistoricas.toString(),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.amber.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
