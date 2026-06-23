import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../data/models/habit_model.dart';
import '../cubit/habits_cubit.dart';

class AddHabitPage extends StatefulWidget {
  const AddHabitPage({super.key, this.habitId});

  final String? habitId;

  @override
  State<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _targetController = TextEditingController(text: '1');
  HabitType _type = HabitType.positive;
  HabitFrequency _frequency = HabitFrequency.daily;
  Habit? _editingHabit;

  bool get _isEditing => widget.habitId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      context.read<HabitsCubit>().loadHabit(widget.habitId!);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: Text(_isEditing ? 'Edit Habit' : 'Add Habit'),
      ),
      body: BlocConsumer<HabitsCubit, HabitsState>(
        listener: (context, state) {
          if (state is HabitsLoaded) {
            if (_isEditing && state.selectedHabit != null) {
              _applyHabit(state.selectedHabit!);
            } else if (!_isEditing) {
              context.pop();
            }
          }
          if (state is HabitsError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isLoading = state is HabitsLoading;
          return Form(
            key: _formKey,
            child: ListView(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _TabChip(
                        label: 'Positive',
                        selected: _type == HabitType.positive,
                        onTap: () => setState(() => _type = HabitType.positive),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _TabChip(
                        label: 'Shadow',
                        selected: _type == HabitType.shadow,
                        onTap: () => setState(() => _type = HabitType.shadow),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Habit name',
                    hintText: _type == HabitType.positive
                        ? 'Read 10 pages'
                        : 'Doom scrolling',
                    prefixIcon: Icon(
                      _type == HabitType.positive
                          ? PhosphorIconsBold.checkCircle
                          : PhosphorIconsBold.skull,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter a habit name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _targetController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Target count',
                    hintText: '1',
                  ),
                  validator: (value) {
                    final parsed = int.tryParse(value ?? '');
                    if (parsed == null || parsed < 1) {
                      return 'Enter a target of 1 or more';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  'Frequency',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                ...HabitFrequency.values.map(
                  (frequency) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GlassCard(
                      onTap: () => setState(() => _frequency = frequency),
                      borderColor: _frequency == frequency
                          ? AppColors.accent
                          : null,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _frequency == frequency
                                ? PhosphorIconsFill.checkCircle
                                : PhosphorIconsBold.circle,
                            color: _frequency == frequency
                                ? AppColors.accent
                                : AppColors.textMuted,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              frequency.name,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                RizenButton(
                  label: _isEditing ? 'Save Habit' : 'Create Habit',
                  isLoading: isLoading,
                  onPressed: isLoading ? null : _submit,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _applyHabit(Habit habit) {
    if (_editingHabit?.id == habit.id) return;
    _editingHabit = habit;
    _nameController.text = habit.name;
    _targetController.text = habit.targetCount.toString();
    setState(() {
      _type = habit.type;
      _frequency = habit.frequency;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<HabitsCubit>();
    final targetCount = int.parse(_targetController.text);
    if (_isEditing && _editingHabit != null) {
      await cubit.updateHabit(
        _editingHabit!.copyWith(
          name: _nameController.text.trim(),
          type: _type,
          frequency: _frequency,
          targetCount: targetCount,
        ),
      );
      if (mounted) context.pop();
      return;
    }

    await cubit.createHabit(
      name: _nameController.text.trim(),
      type: _type,
      frequency: _frequency,
      targetCount: targetCount,
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.accent.withValues(alpha: 0.2)
              : AppColors.glassFill,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.accent : AppColors.glassBorder,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: selected ? AppColors.accent : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
