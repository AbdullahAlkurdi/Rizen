import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../bloc/routines_bloc.dart';

class EditRoutinePage extends StatefulWidget {
  final String routineId;

  const EditRoutinePage({super.key, required this.routineId});

  @override
  State<EditRoutinePage> createState() => _EditRoutinePageState();
}

class _EditRoutinePageState extends State<EditRoutinePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _frequency = 'daily';
  bool _isSubmitting = false;

  static const _frequencyOptions = [
    _FrequencyOption('daily', 'Daily', PhosphorIconsBold.sun),
    _FrequencyOption('weekly', 'Weekly', PhosphorIconsBold.calendar),
    _FrequencyOption('custom', 'Custom', PhosphorIconsBold.gear),
  ];

  @override
  void initState() {
    super.initState();
    _loadRoutine();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadRoutine() async {
    await context.read<RoutineCubit>().loadRoutineDetail(widget.routineId);
    if (!mounted) return;
    final routine = context.read<RoutineCubit>().state.selectedRoutine;
    if (routine != null) {
      setState(() {
        _nameController.text = routine.title;
        _descriptionController.text = routine.description;
        _frequency = routine.frequency;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    try {
      await context.read<RoutineCubit>().updateRoutineDetails(
        routineId: widget.routineId,
        title: _nameController.text,
        description: _descriptionController.text,
        frequency: _frequency,
      );
      if (mounted) {
        context.pop();
      }
    } catch (_) {
      // handled in cubit
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutineCubit, RoutineState>(
      buildWhen: (prev, curr) =>
          curr.selectedRoutine != null || curr.isLoading || curr.error != null,
      builder: (context, state) {
        final routine = state.selectedRoutine;
        final isLoaded = routine != null;
        return RizenScaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(PhosphorIconsBold.arrowLeft),
              onPressed: () => context.pop(),
            ),
            title: const Text('Edit Routine'),
          ),
          body: state.isLoading && !isLoaded
              ? const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SkeletonCard(height: 60),
                      SizedBox(height: 16),
                      SkeletonLine(height: 16),
                      SizedBox(height: 12),
                      SkeletonLine(height: 16),
                      SizedBox(height: 12),
                      SkeletonLine(height: 16),
                    ],
                  ),
                )
              : !isLoaded
              ? const Center(child: Text('Routine not found'))
              : ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Routine Name',
                              prefixIcon: Icon(PhosphorIconsBold.pen),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Routine name is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _descriptionController,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                              prefixIcon: Icon(PhosphorIconsBold.textAa),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Frequency',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 12),
                          ..._frequencyOptions.map((opt) {
                            final selected = _frequency == opt.value;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: GlassCard(
                                onTap: () =>
                                    setState(() => _frequency = opt.value),
                                borderColor: selected ? AppColors.accent : null,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 14,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      selected
                                          ? PhosphorIconsFill.checkCircle
                                          : opt.icon,
                                      color: selected
                                          ? AppColors.accent
                                          : AppColors.textMuted,
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Text(
                                        opt.label,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 32),
                          RizenButton(
                            label: 'Save Changes',
                            icon: PhosphorIconsBold.floppyDisk,
                            isLoading: state.isLoading,
                            onPressed: _isSubmitting ? null : _submit,
                          ),
                          if (state.error != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Text(
                                state.error!,
                                style: const TextStyle(color: Colors.red),
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

class _FrequencyOption {
  const _FrequencyOption(this.value, this.label, this.icon);
  final String value;
  final String label;
  final IconData icon;
}
