import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class EditRoutinePage extends StatelessWidget {
  const EditRoutinePage({super.key});

  static const _blocks = [
    _BlockItem(
      '6:00 AM',
      'Fajr + Reflection',
      PhosphorIconsBold.sunHorizon,
      Color(0xFFFBBF24),
    ),
    _BlockItem(
      '6:30 AM',
      'Deep Coding Session',
      PhosphorIconsBold.code,
      Color(0xFF60A5FA),
    ),
    _BlockItem(
      '8:00 AM',
      'Breakfast & Planning',
      PhosphorIconsBold.bowlFood,
      Color(0xFFFB923C),
    ),
    _BlockItem(
      '8:45 AM',
      'Professional Work Blocks',
      PhosphorIconsBold.briefcase,
      Color(0xFF38BDF8),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('Edit Routine'),
        actions: [TextButton(onPressed: () {}, child: const Text('Save'))],
      ),
      body: ListView(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Routine Name',
              hintText: 'Morning Power Routine',
              prefixIcon: Icon(Icons.edit_outlined),
            ),
          ),
          const SizedBox(height: 24),
          Text('Time Blocks', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          ..._blocks.map(
            (block) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                onTap: () {},
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 44,
                      decoration: BoxDecoration(
                        color: block.color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            block.time,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            block.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    Icon(block.icon, color: block.color, size: 18),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          RizenButton(
            label: 'Add Time Block',
            variant: RizenButtonVariant.secondary,
            icon: PhosphorIconsBold.plus,
            onPressed: () {},
          ),
          const SizedBox(height: 12),
          NavGlassTile(
            title: 'Visual Time-Block Editor',
            subtitle: 'Drag and drop chronological timeline grid.',
            icon: PhosphorIconsBold.listDashes,
            iconColor: Color(0xFF818CF8),
            onTap: () => context.push(AppRoutes.routineTimeBlocks),
          ),
        ],
      ),
    );
  }
}

class _BlockItem {
  const _BlockItem(this.time, this.title, this.icon, this.color);

  final String time;
  final String title;
  final IconData icon;
  final Color color;
}
