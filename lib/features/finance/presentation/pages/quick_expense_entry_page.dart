import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../data/models/transaction_model.dart';
import '../cubit/finance_cubit.dart';

class QuickExpenseEntryPage extends StatefulWidget {
  const QuickExpenseEntryPage({super.key});

  @override
  State<QuickExpenseEntryPage> createState() => _QuickExpenseEntryPageState();
}

class _QuickExpenseEntryPageState extends State<QuickExpenseEntryPage> {
  final _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Quick Expense',
      subtitle: 'Type naturally, confirm the parsed result, then save.',
      body: BlocConsumer<FinanceCubit, FinanceState>(
        listener: (context, state) {
          if (state is FinanceError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is FinanceLoaded && state.manualFallbackInput != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.manualFallbackReason ?? 'Use manual entry.',
                ),
              ),
            );
            context.push(
              AppRoutes.financeManual,
              extra: state.manualFallbackInput,
            );
          }
        },
        builder: (context, state) {
          final parsed = state is FinanceLoaded
              ? state.parsedTransaction
              : null;
          return ListView(
            children: [
              TextField(
                controller: _inputController,
                decoration: const InputDecoration(
                  labelText: 'Expense text',
                  hintText: 'breakfast 18',
                ),
                onSubmitted: (_) => _parse(),
              ),
              const SizedBox(height: 16),
              RizenButton(
                label: 'Parse',
                icon: PhosphorIconsBold.sparkle,
                onPressed: _parse,
              ),
              if (parsed != null) ...[
                const SizedBox(height: 20),
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Parsed result',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      Text('Amount: ${parsed.amount.toStringAsFixed(2)} SAR'),
                      Text('Description: ${parsed.description}'),
                      Text('Category: ${parsed.category ?? 'Uncategorized'}'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                RizenButton(
                  label: 'Confirm Expense',
                  icon: PhosphorIconsBold.check,
                  onPressed: () async {
                    await context.read<FinanceCubit>().addTransaction(
                      amount: parsed.amount,
                      description: parsed.description,
                      category: parsed.category,
                      type: parsed.type,
                      source: TransactionSource.quickEntry,
                    );
                    if (context.mounted) context.pop();
                  },
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  void _parse() {
    context.read<FinanceCubit>().parseQuickEntry(_inputController.text);
  }
}
