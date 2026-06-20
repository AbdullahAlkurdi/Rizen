import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';

class HabitCheckinPage extends StatelessWidget {
  const HabitCheckinPage({super.key});

  static const _habits = [
    _HabitItem('Morning Coding', true, Color(0xFF60A5FA)),
    _HabitItem('Read 10 Pages', true, Color(0xFF818CF8)),
    _HabitItem('No Social Media After 10 PM', false, AppColors.warning),
    _HabitItem('Evening Workout', false, Color(0xFF4ADE80)),
    _HabitItem('Prayer on Time', true, AppColors.warning),
  ];

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Daily Check-in',
      subtitle: 'Instant habit logging in one tap.',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(PhosphorIconsFill.microphone),
        label: Text('Voice Log'),
      ),
      body: ListView(
        children: [
          ..._habits.map(
            (h) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                onTap: () {},
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: h.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        h.title,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Icon(
                      h.completed
                          ? PhosphorIconsFill.checkCircle
                          : PhosphorIconsBold.circle,
                      color: h.completed
                          ? AppColors.success
                          : AppColors.textMuted,
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          RizenButton(
            label: 'Save Check-in',
            icon: PhosphorIconsBold.check,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _HabitItem {
  const _HabitItem(this.title, this.completed, this.color);
  final String title;
  final bool completed;
  final Color color;
}
