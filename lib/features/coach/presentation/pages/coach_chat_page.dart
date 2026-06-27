import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../data/models/coach_message_model.dart';
import '../cubit/coach_cubit.dart';

class CoachChatPage extends StatefulWidget {
  const CoachChatPage({super.key});

  @override
  State<CoachChatPage> createState() => _CoachChatPageState();
}

class _CoachChatPageState extends State<CoachChatPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    context.read<CoachCubit>().sendMessage(text);
    _controller.clear();
  }

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
          IconButton(
            onPressed: () => context.read<CoachCubit>().loadHistory(),
            icon: Icon(PhosphorIconsBold.arrowClockwise),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CoachCubit, CoachState>(
              builder: (context, state) {
                List<CoachMessage> messages;
                if (state is CoachLoaded) {
                  messages = state.messages;
                } else if (state is CoachError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  messages = const <CoachMessage>[];
                }

                if (messages.isEmpty) {
                  return Center(
                    child: Text(
                      'Start the conversation.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }

                return ListView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  children: messages.map((m) {
                    final isUser = m.role == CoachRole.user;
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                                m.content,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
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
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(12, 8, 12, MediaQuery.of(context).padding.bottom + 8),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(
                top: BorderSide(color: Theme.of(context).dividerColor, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _send(),
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      filled: true,
                      fillColor: AppColors.cardBackground,
                      border: OutlineInputBorder(
                        borderRadius: AppTheme.cardRadius,
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _send,
                  icon: const Icon(PhosphorIconsBold.paperPlaneRight),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
