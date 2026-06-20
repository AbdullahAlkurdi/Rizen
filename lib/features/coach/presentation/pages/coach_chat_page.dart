import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class CoachChatPage extends StatelessWidget {
  const CoachChatPage({super.key});

  static const _messages = [
    _ChatMessage(
      'user',
      'I\'ve been struggling with consistency in my study domain.',
    ),
    _ChatMessage(
      'coach',
      'Let\'s look at the data. Your study sessions dip on Wednesdays. Shall we move your study block earlier in the day?',
    ),
    _ChatMessage(
      'user',
      'That could work. I\'m usually more focused in the morning.',
    ),
    _ChatMessage(
      'coach',
      'I\'ll adjust your adaptive routine tonight. Small shifts build consistency without burnout.',
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
        title: const Text('AI Coach Chat'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(PhosphorIconsBold.plus)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: _messages.map((m) {
          final isUser = m.role == 'user';
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              mainAxisAlignment: isUser
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (!isUser) ...[
                  Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.accent, AppColors.shadow],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      PhosphorIconsFill.robot,
                      color: AppColors.textPrimary,
                      size: 14,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Flexible(
                  child: GlassCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Text(
                      m.text,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isUser
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                if (isUser) ...[
                  const SizedBox(width: 8),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      PhosphorIconsBold.user,
                      color: AppColors.textMuted,
                      size: 14,
                    ),
                  ),
                ],
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ChatMessage {
  const _ChatMessage(this.role, this.text);
  final String role;
  final String text;
}
