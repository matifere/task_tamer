import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ranking/cubit/ranking_cubit.dart';
import 'ranking/cubit/ranking_state.dart';
import 'rewards/widgets/cosmetic_name_text.dart';
import 'rewards/widgets/cosmetic_avatar.dart';

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
            final weeklyProgress = state.weeklyProgress;

            if (ranking.isEmpty) {
              return const Center(child: Text("No hay miembros en el grupo."));
            }

            return RefreshIndicator(
              onRefresh: () => context.read<RankingCubit>().loadRanking(),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 16, bottom: 120, left: 16, right: 16),
                itemCount: ranking.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    if (weeklyProgress.isEmpty) {
                      return const SizedBox(height: 16);
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: _WeeklyProgressChart(rawData: weeklyProgress),
                    );
                  }

                  final user = ranking[index - 1];
                  final isMe = user['user_id'] == currentUser?.id;
                  
                  return _RankItem(
                    index: index - 1,
                    name: user['nombre'] ?? 'Sin nombre',
                    monedasHistoricas: user['monedas_historicas'] ?? 0,
                    isMe: isMe,
                    equippedStyle: user['equipped_name_style'] ?? 'default',
                    equippedAvatar: user['equipped_avatar'] ?? 'default',
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
  final String equippedStyle;
  final String equippedAvatar;

  const _RankItem({
    required this.index,
    required this.name,
    required this.monedasHistoricas,
    required this.isMe,
    required this.equippedStyle,
    required this.equippedAvatar,
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
            CosmeticAvatar(
              avatarId: equippedAvatar,
              name: name,
              radius: 20,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CosmeticNameText(
                    text: name,
                    styleId: equippedStyle,
                    baseStyle: theme.textTheme.titleMedium?.copyWith(
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

class _WeeklyProgressChart extends StatelessWidget {
  final List<Map<String, dynamic>> rawData;

  const _WeeklyProgressChart({required this.rawData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // 0 = Lunes, 6 = Domingo
    final currentDayIndex = DateTime.now().weekday - 1;

    final List<Color> palette = [
      colorScheme.primary,
      Colors.amber.shade600,
      Colors.pinkAccent.shade400,
      Colors.teal,
      Colors.purple,
      Colors.orange,
      Colors.indigo,
      Colors.redAccent,
      Colors.cyan,
      Colors.lightGreen,
    ];

    // Parse data
    final Map<String, Map<String, dynamic>> userMap = {};
    int colorIndex = 0;
    double maxY = 100.0; // Valor minimo para Y maximo

    for (final row in rawData) {
      final userId = row['user_id'] as String;
      if (!userMap.containsKey(userId)) {
        userMap[userId] = {
          'name': row['nombre'] ?? 'Desconocido',
          'color': palette[colorIndex % palette.length],
          'data': List<double>.filled(7, 0.0),
        };
        colorIndex++;
      }
      
      final day = row['day_of_week'] as int;
      final monedas = (row['monedas'] as num).toDouble();
      
      if (day >= 0 && day < 7) {
        userMap[userId]!['data'][day] = monedas;
        if (monedas > maxY) {
          maxY = monedas + 50.0;
        }
      }
    }

    final parsedUsers = userMap.values.toList();

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.timeline_rounded, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  "Competencia Semanal",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Leyenda Wrap
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: parsedUsers.map((user) {
                return _LegendItem(
                  color: user['color'] as Color, 
                  name: user['name'] as String
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: maxY,
                  minX: 0,
                  maxX: 6,
                  lineTouchData: LineTouchData(
                    handleBuiltInTouches: true,
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (group) => colorScheme.surface,
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          final user = parsedUsers[spot.barIndex];
                          final name = user['name'] as String;
                          final color = user['color'] as Color;
                          
                          return LineTooltipItem(
                            '$name\n${spot.y.toInt()} 🪙',
                            TextStyle(
                              color: color,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 100,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                        strokeWidth: 1,
                        dashArray: [5, 5],
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 12);
                          String text;
                          switch (value.toInt()) {
                            case 0: text = 'L'; break;
                            case 1: text = 'M'; break;
                            case 2: text = 'X'; break;
                            case 3: text = 'J'; break;
                            case 4: text = 'V'; break;
                            case 5: text = 'S'; break;
                            case 6: text = 'D'; break;
                            default: text = ''; break;
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(text, style: style.copyWith(color: colorScheme.onSurfaceVariant)),
                          );
                        },
                        interval: 1,
                        reservedSize: 28,
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: parsedUsers.map((user) {
                    return _createLine(
                      user['data'] as List<double>, 
                      user['color'] as Color,
                      currentDayIndex,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartBarData _createLine(List<double> data, Color color, int currentDayIndex) {
    // Limitamos los puntos a dibujar hasta el dia de hoy
    final limit = (currentDayIndex + 1).clamp(0, 7);
    
    return LineChartBarData(
      spots: List.generate(limit, (index) => FlSpot(index.toDouble(), data[index])),
      isCurved: true,
      preventCurveOverShooting: true,
      curveSmoothness: 0.25,
      color: color,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          final isZero = spot.y == 0.0;
          return FlDotCirclePainter(
            radius: isZero ? 0 : 4,
            color: color,
            strokeWidth: isZero ? 0 : 2,
            strokeColor: Colors.white,
          );
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        color: color.withValues(alpha: 0.05),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String name;

  const _LegendItem({required this.color, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          name,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
