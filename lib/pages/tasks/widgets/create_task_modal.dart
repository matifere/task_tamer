import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tamer/l10n/app_localizations.dart';
import '../cubit/create_task_cubit.dart';
import '../cubit/create_task_state.dart';

class CreateTaskModal extends StatefulWidget {
  final String groupId;

  const CreateTaskModal({super.key, required this.groupId});

  @override
  State<CreateTaskModal> createState() => _CreateTaskModalState();
}

class _CreateTaskModalState extends State<CreateTaskModal> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  bool _esReutilizable = true;
  String _frecuencia = 'instantaneo';
  double _multiplicador = 1.0;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    context.read<CreateTaskCubit>().createTask(
          groupId: widget.groupId,
          titulo: _titleController.text,
          descripcion: _descController.text,
          esReutilizable: _esReutilizable,
          frecuenciaReinicio: _frecuencia,
          multiplicadorDificultad: _multiplicador,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<CreateTaskCubit, CreateTaskState>(
      listener: (context, state) {
        if (state is CreateTaskSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.taskCreatedSuccessfully),
              backgroundColor: colorScheme.primary,
            ),
          );
          Navigator.pop(context, true); // Retornar true si se creó
        } else if (state is CreateTaskFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is CreateTaskLoading;

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.createTaskTitle,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _titleController,
                  enabled: !isLoading,
                  decoration: InputDecoration(
                    labelText: l10n.taskTitleLabel,
                    prefixIcon: const Icon(Icons.title),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descController,
                  enabled: !isLoading,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: l10n.taskDescLabel,
                    prefixIcon: const Icon(Icons.description),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: Text(l10n.isReusableLabel),
                  value: _esReutilizable,
                  onChanged: isLoading
                      ? null
                      : (val) {
                          setState(() => _esReutilizable = val);
                        },
                ),
                if (_esReutilizable) ...[
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _frecuencia,
                    decoration: InputDecoration(
                      labelText: l10n.resetFrequencyLabel,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    items: [
                      DropdownMenuItem(value: 'instantaneo', child: Text(l10n.freqInstant)),
                      DropdownMenuItem(value: 'diario', child: Text(l10n.freqDaily)),
                      DropdownMenuItem(value: 'semanal', child: Text(l10n.freqWeekly)),
                    ],
                    onChanged: isLoading
                        ? null
                        : (val) {
                            if (val != null) setState(() => _frecuencia = val);
                          },
                  ),
                ],
                const SizedBox(height: 16),
                Text(
                  '${l10n.difficultyMultiplierLabel}: ${_multiplicador.toStringAsFixed(1)}x',
                  style: theme.textTheme.bodyMedium,
                ),
                Slider(
                  value: _multiplicador,
                  min: 1.0,
                  max: 5.0,
                  divisions: 8,
                  label: '${_multiplicador.toStringAsFixed(1)}x',
                  onChanged: isLoading
                      ? null
                      : (val) {
                          setState(() => _multiplicador = val);
                        },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: isLoading ? null : () => _submit(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : Text(l10n.createTaskAction, style: const TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
