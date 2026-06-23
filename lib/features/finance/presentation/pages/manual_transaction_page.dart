import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../data/models/transaction_model.dart';
import '../cubit/finance_cubit.dart';

class ManualTransactionPage extends StatefulWidget {
  const ManualTransactionPage({super.key, this.initialDescription});

  final String? initialDescription;

  @override
  State<ManualTransactionPage> createState() => _ManualTransactionPageState();
}

class _ManualTransactionPageState extends State<ManualTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  TransactionType _type = TransactionType.expense;

  @override
  void initState() {
    super.initState();
    _descriptionController.text = widget.initialDescription ?? '';
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Manual Transaction',
      subtitle: 'Structured fallback when quick entry is not enough.',
      body: BlocListener<FinanceCubit, FinanceState>(
        listener: (context, state) {
          if (state is FinanceLoaded) context.pop();
          if (state is FinanceError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
                validator: _positiveNumber,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: _required,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<TransactionType>(
                initialValue: _type,
                items: TransactionType.values
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type.name)),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _type = value ?? _type),
                decoration: const InputDecoration(labelText: 'Type'),
              ),
              const SizedBox(height: 24),
              RizenButton(
                label: 'Save Transaction',
                icon: PhosphorIconsBold.check,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await context.read<FinanceCubit>().addTransaction(
      amount: double.parse(_amountController.text),
      description: _descriptionController.text.trim(),
      category: _categoryController.text.trim().isEmpty
          ? null
          : _categoryController.text.trim(),
      type: _type,
      source: TransactionSource.manual,
    );
  }

  String? _required(String? value) {
    return value == null || value.trim().isEmpty ? 'Required' : null;
  }

  String? _positiveNumber(String? value) {
    final parsed = double.tryParse(value ?? '');
    return parsed == null || parsed <= 0 ? 'Enter a positive amount' : null;
  }
}
