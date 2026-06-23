import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../bloc/routines_bloc.dart';

class CreateRoutinePage extends StatefulWidget {
  const CreateRoutinePage({super.key});

  @override
  State<CreateRoutinePage> createState() => _CreateRoutinePageState();
}

class _CreateRoutinePageState extends State<CreateRoutinePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _trigger = 'time_based';
  bool _isActive = true;
  bool _isSubmitting = false;

  final List<(String, String, IconData)> _triggers = [
    ('time_based', 'Time-based', PhosphorIconsBold.clock),
    ('prayer_relative', 'Prayer-relative', PhosphorIconsBold.moonStars),
    ('location_based', 'Location-based', PhosphorIconsBold.mapPin),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Routine Name',
                  hintText: 'e.g. Morning Power Routine',
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
                  labelText: 'Description (Optional)',
                  hintText: 'What is this routine for?',
                ),
              ),
              const SizedBox(height: 24),
              Text('Trigger Mode', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              ..._triggers.map((t) {
                final selected = _trigger == t.$1;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GlassCard(
                    onTap: () => setState(() => _trigger = t.$1),
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
                              : t.$3,
                          color: selected ? AppColors.accent : AppColors.textMuted,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            t.$2,
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
              BlocBuilder<RoutineCubit, RoutineState>(
                buildWhen: (prev, curr) => curr.isLoading || curr.error != null,
                builder: (context, state) {
                  return RizenButton(
                    label: 'Create Routine',
                    icon: PhosphorIconsBold.plus,
                    isLoading: state.isLoading,
                    onPressed: _isSubmitting ? null : _submit,
                  );
                },
              ),
              if (context.select<RoutineCubit, bool>((c) => c.state.error != null))
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    context.read<RoutineCubit>().state.error ?? '',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    try {
      await context.read<RoutineCubit>().createRoutine(
            _nameController.text,
            _descriptionController.text,
          );
      if (mounted) {
        context.pop();
      }
    } catch (e) {
      // Error handled in cubit
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}