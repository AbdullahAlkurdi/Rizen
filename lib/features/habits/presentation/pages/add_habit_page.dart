import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class AddHabitPage extends StatefulWidget {
  const AddHabitPage({super.key});

  @override
  State<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  bool _isGoodHabit = true;
  final _nameController = TextEditingController();
  String _frequency = 'Daily';

  static const _frequencies = ['Daily', 'Weekly', 'Custom'];

  @override
  void dispose() {
    _nameController.dispose();
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
        title: Text(_isGoodHabit ? 'Add Good Habit' : 'Add Shadow Habit'),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: _TabChip(
                  label: 'Good Habit',
                  selected: _isGoodHabit,
                  onTap: () => setState(() => _isGoodHabit = true),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _TabChip(
                  label: 'Shadow Habit',
                  selected: !_isGoodHabit,
                  onTap: () => setState(() => _isGoodHabit = false),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Habit Name',
              hintText: _isGoodHabit
                  ? 'e.g. Read 30 pages'
                  : 'e.g. Doom scrolling',
              prefixIcon: Icon(
                _isGoodHabit
                    ? PhosphorIconsBold.checkCircle
                    : PhosphorIconsBold.skull,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Frequency', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          ..._frequencies.map((f) {
            final selected = _frequency == f;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                onTap: () => setState(() => _frequency = f),
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
                          : PhosphorIconsBold.circle,
                      color: selected ? AppColors.accent : AppColors.textMuted,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        f,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 32),
          RizenButton(label: 'Create Habit', onPressed: () => context.pop()),
        ],
      ),
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
