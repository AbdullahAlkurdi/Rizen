import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/router/app_routes.dart';
import '../../../todo/domain/usecases/get_missed_items_usecase.dart';

class TodoMissSuggestion {
  TodoMissSuggestion({
    required this.itemName,
    required this.missCount,
  });

  final String itemName;
  final int missCount;
}

class CoachSuggestionsPage extends StatefulWidget {
  const CoachSuggestionsPage({super.key});

  @override
  State<CoachSuggestionsPage> createState() => _CoachSuggestionsPageState();
}

class _CoachSuggestionsPageState extends State<CoachSuggestionsPage> {
  List<TodoMissSuggestion> _todoSuggestions = [];
  bool _isLoadingTodo = true;

  static const _suggestions = [
    _Suggestion(
      'Shift coding block to 6:30 AM',
      'Your focus score peaks before 8 AM.',
      PhosphorIconsBold.clock,
      Color(0xFF60A5FA),
    ),
    _Suggestion(
      'Move workout after Dhuhr',
      'Matches energy pattern.',
      PhosphorIconsBold.barbell,
      Color(0xFF4ADE80),
    ),
    _Suggestion(
      'Enable evening Recovery Mode',
      'Sleep drift detected.',
      PhosphorIconsBold.firstAid,
      AppColors.warning,
    ),
    _Suggestion(
      'Add Quran reading before bed',
      'Spiritual domain at 90% — small push recommended.',
      PhosphorIconsBold.moonStars,
      AppColors.warning,
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTodoSuggestions();
    });
  }

  Future<void> _loadTodoSuggestions() async {
    setState(() => _isLoadingTodo = true);
    try {
      final missedItemsUseCase = context.read<GetMissedItemsUseCase>();
      final missedItems = await missedItemsUseCase.call(null, 7);
      setState(() {
        _todoSuggestions = missedItems
            .map((i) => TodoMissSuggestion(itemName: i.title, missCount: i.missCount))
            .toList();
        _isLoadingTodo = false;
      });
    } catch (_) {
      setState(() => _isLoadingTodo = false);
    }
  }

  void _navigateToCoachChat(String prefilledMessage) {
    context.push(AppRoutes.coachChat, extra: prefilledMessage);
  }

  void _confirmRemove(String itemName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF16213E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Remove "$itemName"?',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
        ),
        content: Text(
          "This won't delete your habit.",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: AppColors.textMuted)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToCoachChat("Help me remove '$itemName' from my checklist");
            },
            child: const Text('Remove', style: TextStyle(color: Color(0xFFE94560))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'AI Suggestions',
      subtitle: 'Actionable course corrections for today.',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(PhosphorIconsBold.arrowClockwise),
        label: Text('Refresh'),
      ),
      body: ListView(
        children: [
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(PhosphorIconsFill.robot, color: AppColors.accent),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${_suggestions.length} suggestions to optimize your day.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ..._suggestions.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                onTap: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: s.color.withValues(alpha: 0.15),
                        borderRadius: AppTheme.cardRadius,
                      ),
                      child: Icon(s.icon, color: s.color, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.title,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            s.reason,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      PhosphorIconsBold.arrowRight,
                      color: AppColors.textMuted,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (!_isLoadingTodo && _todoSuggestions.isNotEmpty)
            ..._todoSuggestions.map((suggestion) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildTodoMissSuggestionCard(context, suggestion),
            )),
        ],
      ),
    );
  }

  Widget _buildTodoMissSuggestionCard(BuildContext context, TodoMissSuggestion suggestion) {
    return GlassCard(
      borderColor: const Color(0xFFFFB300),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFB300).withValues(alpha: 0.15),
              borderRadius: AppTheme.cardRadius,
            ),
            child: Icon(PhosphorIconsBold.lightning, color: const Color(0xFFFFB300), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${suggestion.itemName} keeps slipping',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  'You\'ve skipped this checklist item 3 days in a row. Small friction points compound. Let\'s fix it.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: [
                    _buildSuggestionChip(context, 'Reschedule', suggestion.itemName),
                    _buildSuggestionChip(context, 'Simplify', suggestion.itemName),
                    _buildRemoveChip(context, suggestion.itemName),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(BuildContext context, String action, String itemName) {
    return InkWell(
      onTap: () => _navigateToCoachChat("Help me $action '$itemName' from my checklist"),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          action,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildRemoveChip(BuildContext context, String itemName) {
    return InkWell(
      onTap: () => _confirmRemove(itemName),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFFFB300).withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Remove',
          style: TextStyle(
            color: const Color(0xFFFFB300),
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _Suggestion {
  const _Suggestion(
    this.title,
    this.reason,
    this.icon,
    this.color,
  );
  final String title;
  final String reason;
  final IconData icon;
  final Color color;
}