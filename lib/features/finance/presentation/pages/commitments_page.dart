import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../data/models/financial_commitment_model.dart';
import '../cubit/finance_cubit.dart';

class CommitmentsPage extends StatefulWidget {
  const CommitmentsPage({super.key});

  @override
  State<CommitmentsPage> createState() => _CommitmentsPageState();
}

class _CommitmentsPageState extends State<CommitmentsPage> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  CommitmentFrequency _frequency = CommitmentFrequency.monthly;

  @override
  void initState() {
    super.initState();
    context.read<FinanceCubit>().loadFinance();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Commitments',
      subtitle: 'Recurring commitments are deducted from monthly visibility.',
      body: BlocBuilder<FinanceCubit, FinanceState>(
        builder: (context, state) {
          final commitments = state is FinanceLoaded
              ? state.commitments
              : <FinancialCommitment>[];
          return ListView(
            children: [
              GlassCard(
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Amount'),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<CommitmentFrequency>(
                      initialValue: _frequency,
                      items: CommitmentFrequency.values
                          .map(
                            (frequency) => DropdownMenuItem(
                              value: frequency,
                              child: Text(frequency.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() => _frequency = value ?? _frequency);
                      },
                      decoration: const InputDecoration(labelText: 'Frequency'),
                    ),
                    const SizedBox(height: 16),
                    RizenButton(
                      label: 'Add Commitment',
                      icon: PhosphorIconsBold.plus,
                      onPressed: _addCommitment,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              if (commitments.isEmpty)
                const GlassCard(child: Text('No recurring commitments yet.'))
              else
                ...commitments.map(
                  (commitment) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GlassCard(
                      child: Row(
                        children: [
                          Icon(
                            commitment.active
                                ? PhosphorIconsFill.calendarCheck
                                : PhosphorIconsBold.pauseCircle,
                            color: commitment.active
                                ? AppColors.success
                                : AppColors.textMuted,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  commitment.name,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  '${commitment.amount.toStringAsFixed(2)} SAR · ${commitment.frequency.name}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () => _editCommitment(commitment),
                            child: const Text('Edit'),
                          ),
                          TextButton(
                            onPressed: commitment.active
                                ? () => context
                                      .read<FinanceCubit>()
                                      .deactivateCommitment(commitment.id)
                                : () => context
                                      .read<FinanceCubit>()
                                      .reactivateCommitment(commitment.id),
                            child: Text(
                              commitment.active ? 'Deactivate' : 'Reactivate',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _addCommitment() async {
    final amount = double.tryParse(_amountController.text);
    if (_nameController.text.trim().isEmpty || amount == null || amount <= 0) {
      return;
    }
    await context.read<FinanceCubit>().addCommitment(
      name: _nameController.text.trim(),
      amount: amount,
      frequency: _frequency,
    );
    _nameController.clear();
    _amountController.clear();
  }

  Future<void> _editCommitment(FinancialCommitment commitment) async {
    final nameController = TextEditingController(text: commitment.name);
    final amountController = TextEditingController(
      text: commitment.amount.toStringAsFixed(2),
    );
    var frequency = commitment.frequency;

    final updated = await showDialog<FinancialCommitment>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Edit Commitment'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Amount'),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<CommitmentFrequency>(
                    initialValue: frequency,
                    items: CommitmentFrequency.values
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(value.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setDialogState(() => frequency = value ?? frequency);
                    },
                    decoration: const InputDecoration(labelText: 'Frequency'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    final amount = double.tryParse(amountController.text);
                    if (nameController.text.trim().isEmpty ||
                        amount == null ||
                        amount <= 0) {
                      return;
                    }
                    Navigator.of(context).pop(
                      commitment.copyWith(
                        name: nameController.text.trim(),
                        amount: amount,
                        frequency: frequency,
                      ),
                    );
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );

    nameController.dispose();
    amountController.dispose();
    if (updated == null || !mounted) return;
    await context.read<FinanceCubit>().updateCommitment(updated);
  }
}
