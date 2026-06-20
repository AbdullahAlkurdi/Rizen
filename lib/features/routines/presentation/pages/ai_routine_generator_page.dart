import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';

class AiRoutineGeneratorPage extends StatefulWidget {
  const AiRoutineGeneratorPage({super.key});

  @override
  State<AiRoutineGeneratorPage> createState() => _AiRoutineGeneratorPageState();
}

class _AiRoutineGeneratorPageState extends State<AiRoutineGeneratorPage> {
  final _controller = TextEditingController();
  bool _isGenerating = false;
  bool _showResult = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _generate() async {
    if (_controller.text.trim().isEmpty) return;
    setState(() => _isGenerating = true);
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _isGenerating = false;
      _showResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'AI Routine Generator',
      subtitle: 'Describe your ideal day and Gemini builds the schedule.',
      floatingActionButton: _showResult
          ? FloatingActionButton.extended(
              onPressed: () {},
              icon: Icon(PhosphorIconsBold.check),
              label: Text('Apply Routine'),
            )
          : null,
      body: ListView(
        children: [
          GlassCard(
            child: Row(
              children: [
                Icon(PhosphorIconsFill.robot, color: AppColors.accent),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Gemini 2.0 Flash is ready to design your adaptive schedule.',
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
            label: _isGenerating ? 'Generating...' : 'Generate with AI',
            icon: PhosphorIconsBold.magicWand,
            isLoading: _isGenerating,
            onPressed: _generate,
          ),
          if (_showResult) ...[
            const SizedBox(height: 24),
            Text(
              'Generated Routine',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            ...List.generate(4, (i) {
              final blocks = [
                (
                  'Fajr Prayer',
                  '06:00 - 06:20',
                  PhosphorIconsBold.moonStars,
                  AppColors.warning,
                ),
                (
                  'Morning Coding',
                  '06:30 - 07:30',
                  PhosphorIconsBold.code,
                  Color(0xFF60A5FA),
                ),
                (
                  'Workout',
                  '07:45 - 08:15',
                  PhosphorIconsBold.barbell,
                  Color(0xFF4ADE80),
                ),
                (
                  'Work Focus',
                  '09:00 - 12:00',
                  PhosphorIconsBold.briefcase,
                  Color(0xFF38BDF8),
                ),
              ][i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GlassCard(
                  child: Row(
                    children: [
                      Icon(blocks.$3, color: blocks.$4, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              blocks.$1,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              blocks.$2,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        PhosphorIconsBold.checkCircle,
                        color: AppColors.success,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
}
