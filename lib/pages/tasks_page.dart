import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:lottie/lottie.dart';
import 'package:task_tamer/l10n/app_localizations.dart';
import 'active_task_page.dart';
import 'tasks/cubit/active_task_cubit.dart';
import 'tasks/cubit/create_task_cubit.dart';
import 'tasks/cubit/tasks_cubit.dart';
import 'tasks/cubit/tasks_state.dart';
import 'tasks/widgets/create_task_modal.dart';

class TasksPage extends StatelessWidget {
  final String groupId;
  final String groupCode;

  const TasksPage({
    super.key,
    required this.groupId,
    required this.groupCode,
  });

  @override
  Widget build(BuildContext context) {
    return const _TasksView();
  }
}

class _TasksView extends StatelessWidget {
  const _TasksView();


  Widget _buildTopHeader(BuildContext context, ThemeData theme, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colorScheme.primary.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.group_add_rounded, color: colorScheme.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Código del grupo",
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          context.read<TasksCubit>().groupCode,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.copy_rounded, color: colorScheme.primary, size: 20),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: context.read<TasksCubit>().groupCode));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('¡Código del grupo copiado!'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: colorScheme.primary,
                        ),
                      );
                    },
                    tooltip: "Copiar código",
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ]
            ),
            child: IconButton(
              icon: Icon(Icons.refresh_rounded, color: colorScheme.primary),
              onPressed: () => context.read<TasksCubit>().loadTasks(),
              tooltip: "Recargar tareas",
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateTaskModal(BuildContext context, {Map<String, dynamic>? taskToEdit}) async {
    final tasksCubit = context.read<TasksCubit>();
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return BlocProvider(
          create: (_) => CreateTaskCubit(),
          child: CreateTaskModal(groupId: tasksCubit.groupId, taskToEdit: taskToEdit),
        );
      },
    );

    if (result == true) {
      tasksCubit.loadTasks();
    }
  }

  void _confirmDeleteTask(BuildContext context, String taskId, String title) {
    final tasksCubit = context.read<TasksCubit>();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar tarea'),
        content: Text('¿Seguro que deseas eliminar "$title"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          FilledButton(
            onPressed: () {
              Vibration.vibrate(duration: 100);
              Navigator.pop(ctx);
              tasksCubit.deleteTask(taskId);
            },
            style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: Colors.transparent, // Dejamos que MainLayout maneje el fondo
      body: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          if (state is TasksLoading || state is TasksInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TasksError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: colorScheme.error),
                  const SizedBox(height: 16),
                  Text(
                    "Error al cargar las tareas",
                    style: theme.textTheme.titleMedium?.copyWith(color: colorScheme.error),
                  ),
                  TextButton(
                    onPressed: () => context.read<TasksCubit>().loadTasks(),
                    child: const Text("Reintentar"),
                  )
                ],
              ),
            );
          }

          if (state is TasksLoaded) {
            final tasks = state.tasks;

            if (tasks.isEmpty) {
              return Column(
                children: [
                  _buildTopHeader(context, theme, colorScheme),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.assignment_outlined, size: 80, color: colorScheme.primary.withValues(alpha: 0.5)),
                            const SizedBox(height: 24),
                            Text(
                              l10n.emptyTasksTitle,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              l10n.emptyTasksDesc,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [
                _buildTopHeader(context, theme, colorScheme),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100.0), // Espacio para el nav bar
                    child: CardSwiper(
                      cardsCount: tasks.length,
                      isLoop: true,
                      allowedSwipeDirection: const AllowedSwipeDirection.symmetric(horizontal: true),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      onSwipe: (previousIndex, currentIndex, direction) {
                        Vibration.vibrate(duration: 50);
                        if (direction == CardSwiperDirection.right) {
                          final task = tasks[previousIndex];
                          final multiplierString = task['multiplicador_dificultad']?.toString() ?? '1.0';
                          final multiplier = double.tryParse(multiplierString) ?? 1.0;

                          Color difficultyColor;
                          String lottieAsset;
                          if (multiplier < 2.0) {
                            difficultyColor = Colors.cyan;
                            lottieAsset = 'assets/squinting_tongue.lottie';
                          } else if (multiplier < 3.0) {
                            difficultyColor = Colors.teal;
                            lottieAsset = 'assets/smile.lottie';
                          } else if (multiplier < 4.0) {
                            difficultyColor = Colors.amber;
                            lottieAsset = 'assets/grimacing.lottie';
                          } else if (multiplier < 4.8) {
                            difficultyColor = Colors.deepOrange;
                            lottieAsset = 'assets/melting.lottie';
                          } else {
                            difficultyColor = Colors.purple;
                            lottieAsset = 'assets/crying_loudly.lottie';
                          }

                          final tasksCubit = context.read<TasksCubit>();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                create: (_) => ActiveTaskCubit(),
                                child: ActiveTaskPage(
                                  task: task,
                                  groupId: tasksCubit.groupId,
                                  lottieAsset: lottieAsset,
                                  difficultyColor: difficultyColor,
                                  multiplier: multiplier,
                                ),
                              ),
                            ),
                          ).then((result) {
                            if (result == true) {
                              tasksCubit.loadTasks(); // recargar
                            }
                          });
                        }
                        return true;
                      },
                      cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                        final task = tasks[index];
                        final isReusable = task['es_reutilizable'] as bool? ?? false;
                        final frecuencia = task['frecuencia_reinicio']?.toString() ?? 'instantaneo';
                        final multiplierString = task['multiplicador_dificultad']?.toString() ?? '1.0';
                        final multiplier = double.tryParse(multiplierString) ?? 1.0;

                        String frecuenciaLabel = l10n.freqInstant;
                        IconData frecuenciaIcon = Icons.flash_on_rounded;
                        if (frecuencia == 'diario') {
                          frecuenciaLabel = l10n.freqDaily;
                          frecuenciaIcon = Icons.calendar_today_rounded;
                        } else if (frecuencia == 'semanal') {
                          frecuenciaLabel = l10n.freqWeekly;
                          frecuenciaIcon = Icons.date_range_rounded;
                        }

                        Color difficultyColor;
                        String lottieAsset;
                        if (multiplier < 2.0) {
                          difficultyColor = Colors.cyan; // 1.x
                          lottieAsset = 'assets/squinting_tongue.lottie';
                        } else if (multiplier < 3.0) {
                          difficultyColor = Colors.teal; // 2.x
                          lottieAsset = 'assets/smile.lottie';
                        } else if (multiplier < 4.0) {
                          difficultyColor = Colors.amber; // 3.x
                          lottieAsset = 'assets/grimacing.lottie';
                        } else if (multiplier < 4.8) {
                          difficultyColor = Colors.deepOrange; // 4.x
                          lottieAsset = 'assets/melting.lottie';
                        } else {
                          difficultyColor = Colors.purple; // 5.0
                          lottieAsset = 'assets/crying_loudly.lottie';
                        }

                        // percentThresholdX va de -100 a 100 (aprox) según el swipe
                        final clampedX = percentThresholdX.clamp(-100, 100);
                        
                        Color? overlayColor;
                        if (clampedX > 0) {
                          overlayColor = Colors.green.withValues(alpha: (clampedX / 100.0) * 0.6);
                        } else if (clampedX < 0) {
                          overlayColor = Colors.red.withValues(alpha: (clampedX.abs() / 100.0) * 0.6);
                        } else {
                          overlayColor = Colors.transparent;
                        }

                        return Container(
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.shadow.withValues(alpha: 0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              )
                            ],
                            border: Border.all(
                              color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: Stack(
                              children: [
                                // Fondo decorativo (gradiente suave por defecto)
                                Positioned.fill(
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          difficultyColor.withValues(alpha: 0.25),
                                          colorScheme.surface,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // Contenido principal de la tarjeta
                                Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.edit_rounded, color: colorScheme.onSurface.withValues(alpha: 0.5)),
                                            onPressed: () => _showCreateTaskModal(context, taskToEdit: task),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete_rounded, color: colorScheme.error.withValues(alpha: 0.8)),
                                            onPressed: () => _confirmDeleteTask(context, task['id'], task['titulo']),
                                          ),
                                        ],
                                      ),
                                      const Spacer(flex: 1),
                                      SizedBox(
                                        height: 120,
                                        child: Lottie.asset(
                                          lottieAsset,
                                          fit: BoxFit.contain,
                                          repeat: true,
                                        ),
                                      ),
                                      const SizedBox(height: 32),
                                      Text(
                                        task['titulo'] ?? '',
                                        style: theme.textTheme.headlineMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: colorScheme.onSurface,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 16),
                                      if (task['descripcion'] != null && task['descripcion'].toString().isNotEmpty)
                                        Text(
                                          task['descripcion'],
                                          style: theme.textTheme.bodyLarge?.copyWith(
                                            color: colorScheme.onSurfaceVariant,
                                            height: 1.5,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      const Spacer(flex: 2),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          _Badge(
                                            icon: Icons.star_rounded,
                                            label: '${l10n.difficulty} ${multiplierString}x',
                                            color: difficultyColor,
                                            backgroundColor: difficultyColor.withValues(alpha: 0.15),
                                          ),
                                          const SizedBox(width: 12),
                                          _Badge(
                                            icon: isReusable ? frecuenciaIcon : Icons.looks_one_rounded,
                                            label: isReusable ? frecuenciaLabel : l10n.oneTime,
                                            color: colorScheme.secondary,
                                            backgroundColor: colorScheme.secondaryContainer,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                                // Capa superpuesta para el feedback de color al hacer swipe
                                Positioned.fill(
                                  child: IgnorePointer(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: overlayColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateTaskModal(context),
        icon: const Icon(Icons.add),
        label: Text(l10n.createTaskTitle),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color backgroundColor;

  const _Badge({
    required this.icon,
    required this.label,
    required this.color,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
