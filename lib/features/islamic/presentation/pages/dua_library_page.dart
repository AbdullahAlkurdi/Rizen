import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../cubit/spiritual_cubit.dart';

class DuaLibraryPage extends StatelessWidget {
  const DuaLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      extendBody: true,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
      body: Column(
        children: [
          const PageHeader(
            title: 'Du\'a Library',
            subtitle: 'Supplications for every occasion.',
          ),
          const SizedBox(height: 12),
          _buildOccasionFilter(context),
          const SizedBox(height: 12),
          Expanded(
            child: BlocBuilder<SpiritualCubit, SpiritualState>(
              builder: (context, state) {
                if (state is SpiritualLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is SpiritualError) {
                  return Center(
                    child: Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                if (state is SpiritualDuaLoaded) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: state.duas.length,
                    itemBuilder: (context, index) {
                      final dua = state.duas[index];
                      final isFavorite = state.favoriteIds.contains(dua.id);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GlassCard(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      dua.arabicText,
                                      style: Theme.of(context).textTheme.bodyLarge,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => context
                                        .read<SpiritualCubit>()
                                        .toggleDuaFavorite(dua.id),
                                    icon: Icon(
                                      isFavorite
                                          ? PhosphorIconsFill.star
                                          : PhosphorIconsRegular.star,
                                      color: isFavorite
                                          ? AppColors.warning
                                          : AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                dua.transliteration,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                dua.translationEn,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                children: dua.occasions
                                    .map(
                                      (o) => Chip(
                                        label: Text(o),
                                        visualDensity: VisualDensity.compact,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: _LoadDuaButton(onPressed: () => context
                      .read<SpiritualCubit>()
                      .loadDuaLibrary()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOccasionFilter(BuildContext context) {
    final occasions = const [
      '',
      'sleep',
      'travel',
      'eating',
      'distress',
      'morning',
      'protection',
      'general',
    ];
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: occasions.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = occasions[index];
          final label = filter.isEmpty ? 'All' : filter;
          return FilterChip(
            label: Text(label),
            selected: false,
            onSelected: (_) {
              context
                  .read<SpiritualCubit>()
                  .loadDuaLibrary(
                    occasionFilter: filter.isEmpty ? null : filter,
                  );
            },
          );
        },
      ),
    );
  }
}

class _LoadDuaButton extends StatelessWidget {
  const _LoadDuaButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RizenButton(
      label: 'Load Du\'a Library',
      icon: PhosphorIconsBold.bookOpenText,
      onPressed: onPressed,
    );
  }
}
