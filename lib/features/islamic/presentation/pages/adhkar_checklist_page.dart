import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../data/models/adhkar_session.dart';
import '../cubit/spiritual_cubit.dart';

class AdhkarChecklistPage extends StatelessWidget {
  const AdhkarChecklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: RizenScaffold(
        extendBody: true,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
        body: Column(
          children: [
            const PageHeader(
              title: 'Adhkar Checklist',
              subtitle: 'Morning and evening remembrances.',
            ),
            const SizedBox(height: 12),
            const TabBar(
              tabs: [
                Tab(text: 'Morning'),
                Tab(text: 'Evening'),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TabBarView(
                children: [
                  _AdhkarTab(session: AdhkarSession.morning),
                  _AdhkarTab(session: AdhkarSession.evening),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdhkarTab extends StatelessWidget {
  const _AdhkarTab({required this.session});

  final AdhkarSession session;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpiritualCubit, SpiritualState>(
      builder: (context, state) {
        return switch (state) {
          SpiritualLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          SpiritualError(:final message) => Center(
              child: Text(
                'Error: $message',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          SpiritualAdhkarLoaded(
            :final adhkarItems,
            :final completedIds,
            :final session,
          ) when session == this.session =>
            ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: adhkarItems.length,
              itemBuilder: (context, index) {
                final item = adhkarItems[index];
                final isCompleted = completedIds.contains(item.id);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GlassCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                final newCompleted = List<String>.from(completedIds);
                                if (isCompleted) {
                                  newCompleted.remove(item.id);
                                } else {
                                  newCompleted.add(item.id);
                                }
                                context
                                    .read<SpiritualCubit>()
                                    .logAdhkarCompletion(
                                      session: session,
                                      completedIds: newCompleted,
                                    );
                              },
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isCompleted
                                      ? AppColors.success
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: AppColors.success,
                                    width: 2,
                                  ),
                                ),
                                child: isCompleted
                                    ? const Icon(
                                        Icons.check,
                                        size: 16,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                item.arabicText,
                                style: Theme.of(context).textTheme.bodyLarge,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.transliteration,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.translationEn,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '×${item.count}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          _ => Center(
              child: RizenButton(
                label: 'Load ${session.name} Adhkar',
                icon: PhosphorIconsBold.arrowRight,
                onPressed: () =>
                    context.read<SpiritualCubit>().loadAdhkarChecklist(session),
              ),
            ),
        };
      },
    );
  }
}
