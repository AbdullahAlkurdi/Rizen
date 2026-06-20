import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class CreateRoutinePage extends StatefulWidget {
  const CreateRoutinePage({super.key});

  @override
  State<CreateRoutinePage> createState() => _CreateRoutinePageState();
}

class _CreateRoutinePageState extends State<CreateRoutinePage> {
  final _nameController = TextEditingController();
  String _trigger = 'Time-based';
  bool _isActive = true;

  static const _triggers = [
    'Time-based',
    'Prayer-relative',
    'Location-based',
    'Energy-based',
  ];

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
        title: const Text('Create Routine'),
      ),
      body: ListView(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Routine Name',
              hintText: 'e.g. Morning Power Routine',
              prefixIcon: Icon(Icons.edit_outlined),
            ),
          ),
          const SizedBox(height: 24),
          Text('Trigger Mode', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          ..._triggers.map((t) {
            final selected = _trigger == t;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                onTap: () => setState(() => _trigger = t),
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
                        t,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 24),
          GlassCard(
            child: SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Active Immediately',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                'Enable this routine upon creation.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              value: _isActive,
              activeTrackColor: AppColors.accent.withValues(alpha: 0.5),
              activeThumbColor: AppColors.accent,
              onChanged: (v) => setState(() => _isActive = v),
            ),
          ),
          const SizedBox(height: 32),
          RizenButton(
            label: 'Create Routine',
            icon: PhosphorIconsBold.plus,
            onPressed: () => context.push(AppRoutes.routineDetail),
          ),
        ],
      ),
    );
  }
}
