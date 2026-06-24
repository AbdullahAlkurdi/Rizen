import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../bloc/routines_bloc.dart';

class AiRoutineGeneratorPage extends StatefulWidget {
  const AiRoutineGeneratorPage({super.key});

  @override
  State<AiRoutineGeneratorPage> createState() => _AiRoutineGeneratorPageState();
}

class _AiRoutineGeneratorPageState extends State<AiRoutineGeneratorPage> {
  final _controller = TextEditingController();
  bool _isGenerating = false;
  bool _showResult = false;
  String? _generatedRoutineId;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _generate() async {
    if (_controller.text.trim().isEmpty) return;
    setState(() => _isGenerating = true);
    try {
      final routineId = await context
          .read<RoutineCubit>()
          .generateRoutineFromPrompt(_controller.text.trim());
      setState(() {
        _isGenerating = false;
        _showResult = routineId != null;
        _generatedRoutineId = routineId;
      });
    } catch (e) {
      setState(() => _isGenerating = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      floatingActionButton: _showResult && _generatedRoutineId != null
          ? FloatingActionButton.extended(
              onPressed: () =>
                  context.push('/routines/detail/$_generatedRoutineId'),
              icon: const Icon(PhosphorIconsBold.check),
              label: const Text('View Generated Routine'),
            )
          : null,
      appBar: AppBar(title: const Text('AI Routine Generator')),
      body: BlocBuilder<RoutineCubit, RoutineState>(
        buildWhen: (prev, curr) =>
            curr.selectedRoutine != prev.selectedRoutine ||
            curr.selectedTimeBlocks != prev.selectedTimeBlocks,
        builder: (context, state) {
          final generatedBlocks = state.selectedTimeBlocks;
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              GlassCard(
                child: Row(
                  children: [
                    Icon(PhosphorIconsFill.robot, color: AppColors.accent),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Describe your ideal day. We will parse your prompt and generate a structured schedule with time blocks.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controller,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText:
                      'e.g. I need a morning routine that includes prayer, 1 hour of coding, and a 30-minute workout before my 9 AM work shift.',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 16),
              RizenButton(
                label: _isGenerating ? 'Generating...' : 'Generate Routine',
                icon: PhosphorIconsBold.magicWand,
                isLoading: _isGenerating,
                onPressed: _generate,
              ),
              if (_showResult && generatedBlocks.isNotEmpty) ...[
                const Text('Generated Routine'),
                const SizedBox(height: 12),
                ...generatedBlocks.map((block) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GlassCard(
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIconsBold.clock,
                            color: AppColors.accent,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  block.title,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  '${block.startTime ~/ 60}:${(block.startTime % 60).toString().padLeft(2, "0")} - ${block.endTime ~/ 60}:${(block.endTime % 60).toString().padLeft(2, "0")}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            PhosphorIconsFill.checkCircle,
                            color: AppColors.success,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
              if (state.error != null) ...[
                const SizedBox(height: 16),
                Text(state.error!, style: const TextStyle(color: Colors.red)),
              ],
            ],
          );
        },
      ),
    );
  }
}
