import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../data/models/transaction_model.dart';
import '../cubit/finance_cubit.dart';

class EmergencyExpensePage extends StatefulWidget {
  const EmergencyExpensePage({super.key});

  @override
  State<EmergencyExpensePage> createState() => _EmergencyExpensePageState();
}

class _EmergencyExpensePageState extends State<EmergencyExpensePage> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Emergency Expense',
      subtitle: 'Amount and description only.',
      body: BlocListener<FinanceCubit, FinanceState>(
        listener: (context, state) {
          if (state is FinanceLoaded) context.pop();
          if (state is FinanceError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: ListView(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 24),
            RizenButton(
              label: 'Save Emergency Expense',
              icon: PhosphorIconsBold.warning,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final amount = double.tryParse(_amountController.text);
    final description = _descriptionController.text.trim();
    if (amount == null || amount <= 0 || description.isEmpty) return;
    await context.read<FinanceCubit>().addTransaction(
      amount: amount,
      description: description,
      category: 'emergency',
      type: TransactionType.expense,
      source: TransactionSource.manual,
    );
  }
}
