import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../cubit/voice_cubit.dart';
import '../cubit/voice_state.dart';

class VoiceLogPage extends StatelessWidget {
  const VoiceLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Voice Log',
      body: BlocConsumer<CoachVoiceCubit, VoiceState>(
        listener: (context, state) {
          if (state is VoiceLogged) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      _MicButton(state: state),
                      const SizedBox(height: 20),
                      if (state is VoiceListening || state is VoiceProcessing) ...[
                        _TranscriptDisplay(
                          transcript: state is VoiceListening
                              ? state.transcript
                              : state is VoiceProcessing
                                  ? state.transcript
                                  : '',
                        ),
                      ],
                      if (state is VoiceParsed) ...[
                        _ResultCard(result: state.result),
                      ],
                      if (state is VoiceHistoryLoading) ...[
                        const _HistorySkeleton(),
                      ],
                      if (state is VoiceHistoryLoaded) ...[
                        _HistoryList(logs: state.logs),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MicButton extends StatelessWidget {
  const _MicButton({required this.state});

  final VoiceState state;

  @override
  Widget build(BuildContext context) {
    final isActive = state is VoiceListening || state is VoiceProcessing;
    return BlocBuilder<CoachVoiceCubit, VoiceState>(
      builder: (context, cubitState) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? const Color(0xFFE94560) : const Color(0xFF0F3460),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: const Color(0xFFE94560).withValues(alpha: 0.4),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ]
                : [],
          ),
          child: IconButton(
            onPressed: () {
              if (isActive) {
                context.read<CoachVoiceCubit>().stopListening();
              } else {
                context.read<CoachVoiceCubit>().startListening();
              }
            },
            icon: Icon(
              PhosphorIconsBold.microphone,
              color: Colors.white,
              size: 40,
            ),
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(24),
            ),
          ),
        );
      },
    );
  }
}

class _TranscriptDisplay extends StatelessWidget {
  const _TranscriptDisplay({required this.transcript});

  final String transcript;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(maxHeight: 200),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Text(
          transcript.isEmpty ? 'Listening...' : transcript,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary,
              ),
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result});

  final CoachVoiceParseResult result;

  @override
  Widget build(BuildContext context) {
    final hasLowConfidence = result.confidenceScore < 0.5;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasLowConfidence) ...[
            Text(
              "I wasn't sure about that. Would you like to edit it before saving?",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.warning,
                  ),
            ),
            const SizedBox(height: 12),
          ],
          if (result.domain != null) ...[
            Wrap(
              spacing: 8,
              children: [
                Chip(
                  label: Text(result.domain!.name.toUpperCase()),
                  backgroundColor: const Color(0xFFE94560).withValues(alpha: 0.2),
                  labelStyle: const TextStyle(
                    color: Color(0xFFE94560),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
          if (result.duration != null) ...[
            Text(
              'Duration: ${result.duration} minutes',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
          ],
          if (result.notes != null) ...[
            Text(
              result.notes!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
          ],
          if (result.todoItems != null && result.todoItems!.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: result.todoItems!
                  .map((item) => Chip(
                        label: Text(item),
                        backgroundColor: const Color(0xFF0F3460),
                        labelStyle: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  context.read<CoachVoiceCubit>().reset();
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: () {
                  context.read<CoachVoiceCubit>().logResult(result);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFE94560),
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HistorySkeleton extends StatelessWidget {
  const _HistorySkeleton();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SkeletonListTile(),
        SizedBox(height: 12),
        SkeletonListTile(),
        SizedBox(height: 12),
        SkeletonListTile(),
      ],
    );
  }
}

class _HistoryList extends StatelessWidget {
  const _HistoryList({required this.logs});

  final List<VoiceHistoryEntry> logs;

  @override
  Widget build(BuildContext context) {
    if (logs.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Voice Logs',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        for (final entry in logs) _HistoryItem(entry),
      ],
    );
  }
}

class _HistoryItem extends StatelessWidget {
  const _HistoryItem(this.entry);

  final VoiceHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F3460).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            PhosphorIconsBold.clock,
            color: AppColors.textMuted,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            '${entry.date.hour.toString().padLeft(2, '0')}:${entry.date.minute.toString().padLeft(2, '0')}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(width: 12),
          if (entry.domain != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFE94560).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                entry.domain!.toUpperCase(),
                style: const TextStyle(
                  color: Color(0xFFE94560),
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          if (entry.duration != null) ...[
            Text(
              '${entry.duration} min',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                  ),
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              entry.notesExcerpt,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}