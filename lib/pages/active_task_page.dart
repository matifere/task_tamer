import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:task_tamer/l10n/app_localizations.dart';
import 'tasks/cubit/active_task_cubit.dart';
import 'tasks/cubit/active_task_state.dart';

class ActiveTaskPage extends StatefulWidget {
  final Map<String, dynamic> task;
  final String groupId;
  final String lottieAsset;
  final Color difficultyColor;
  final double multiplier;

  const ActiveTaskPage({
    super.key,
    required this.task,
    required this.groupId,
    required this.lottieAsset,
    required this.difficultyColor,
    required this.multiplier,
  });

  @override
  State<ActiveTaskPage> createState() => _ActiveTaskPageState();
}

class _ActiveTaskPageState extends State<ActiveTaskPage> {
  Timer? _timer;
  int _secondsElapsed = 0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    // Iniciar automáticamente al abrir la pantalla
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
      setState(() => _isRunning = false);
    } else {
      setState(() => _isRunning = true);
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _secondsElapsed++;
        });
      });
    }
  }

  void _completeTask(BuildContext context) {
    if (_isRunning) {
      _timer?.cancel();
      setState(() => _isRunning = false);
    }
    
    context.read<ActiveTaskCubit>().completeTask(
      taskId: widget.task['id'],
      groupId: widget.groupId,
      secondsElapsed: _secondsElapsed,
      multiplier: widget.multiplier,
    );
  }

  String get _formattedTime {
    final minutes = (_secondsElapsed ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsElapsed % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocConsumer<ActiveTaskCubit, ActiveTaskState>(
      listener: (context, state) {
        if (state is ActiveTaskError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: colorScheme.error),
          );
        }
      },
      builder: (context, state) {
        if (state is ActiveTaskCompleted) {
          return _buildSuccessView(context, state.earnedCoins, l10n, theme, colorScheme);
        }

        final isLoading = state is ActiveTaskLoading;

        return PopScope(
          canPop: false, // Prevents backing out without clicking abandon
          child: Scaffold(
            backgroundColor: colorScheme.surface,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Text(l10n.activeTaskTitle, style: theme.textTheme.titleMedium),
              centerTitle: true,
              actions: [
                if (!isLoading)
                  IconButton(
                    icon: Icon(Icons.close_rounded, color: colorScheme.error),
                    tooltip: l10n.cancelTaskAction,
                    onPressed: () => Navigator.of(context).pop(false),
                  )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  SizedBox(
                    height: 150,
                    child: Lottie.asset(
                      widget.lottieAsset,
                      fit: BoxFit.contain,
                      repeat: true,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    widget.task['titulo'] ?? '',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (widget.task['descripcion'] != null && widget.task['descripcion'].toString().isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      widget.task['descripcion'],
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const SizedBox(height: 48),
                  Text(
                    l10n.timeElapsed.toUpperCase(),
                    style: theme.textTheme.labelLarge?.copyWith(
                      letterSpacing: 2,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formattedTime,
                    style: theme.textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      fontFeatures: const [FontFeature.tabularFigures()],
                      color: _isRunning ? widget.difficultyColor : colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.large(
                        onPressed: isLoading ? null : _toggleTimer,
                        backgroundColor: _isRunning ? colorScheme.secondaryContainer : widget.difficultyColor,
                        foregroundColor: _isRunning ? colorScheme.onSecondaryContainer : colorScheme.onPrimary,
                        elevation: _isRunning ? 1 : 6,
                        child: Icon(
                          _isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                          size: 48,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: (isLoading || _secondsElapsed < 60) ? null : () => _completeTask(context),
                    icon: isLoading 
                      ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.check_circle_rounded),
                    label: Text(l10n.completeTaskAction, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: isLoading ? null : () => Navigator.of(context).pop(false),
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.error,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(l10n.cancelTaskAction, style: const TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSuccessView(BuildContext context, int earnedCoins, AppLocalizations l10n, ThemeData theme, ColorScheme colorScheme) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(flex: 2),
                Lottie.asset(
                  'assets/money.lottie',
                  width: 300,
                  height: 300,
                  repeat: false,
                ),
                const SizedBox(height: 40),
                Text(
                  l10n.earnedCoinsTitle,
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        l10n.earnedCoinsDesc(earnedCoins),
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.monetization_on_rounded,
                      size: 40,
                      color: Colors.amber[600],
                    ),
                  ],
                ),
                const Spacer(flex: 3),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  child: Text(
                    l10n.awesome,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
