import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../finance/presentation/cubit/finance_cubit.dart';

class OnboardingFinanceSetupPage extends StatefulWidget {
  const OnboardingFinanceSetupPage({super.key});

  @override
  State<OnboardingFinanceSetupPage> createState() =>
      _OnboardingFinanceSetupPageState();
}

class _OnboardingFinanceSetupPageState
    extends State<OnboardingFinanceSetupPage> {
  final _incomeController = TextEditingController();
  String _currency = 'SAR';

  static const _currencies = ['SAR', 'USD', 'EUR', 'AED', 'GBP'];

  @override
  void dispose() {
    _incomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go(AppRoutes.onboardingLanguage),
        ),
        title: Text('Setup', style: TextStyle(color: AppColors.textPrimary)),
      ),
      body: BlocConsumer<FinanceCubit, FinanceState>(
        listener: (context, state) {
          if (state is FinanceLoaded) {
            final income = state.currentCycle?.monthlyIncome;
            if (income != null && _incomeController.text.isEmpty) {
              _incomeController.text = income.toStringAsFixed(2);
            }
          }
        },
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const SizedBox(height: 24),
              Text(
                'Finance Setup',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 8),
              Text(
                'Set your monthly income and preferred currency. '
                'Budget tracking starts now.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _incomeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Monthly income',
                  labelStyle: TextStyle(color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _currency,
                items: _currencies
                    .map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(color: AppColors.textPrimary))))
                    .toList(),
                onChanged: (v) => setState(() => _currency = v ?? _currency),
                decoration: const InputDecoration(
                  labelText: 'Currency',
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Your budget resets on the day you set it. '
                'You can adjust later in Settings.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              RizenButton(
                label: 'Continue',
                icon: Icons.arrow_forward,
                isLoading: state is FinanceLoading,
                onPressed: state is FinanceLoading ? null : _save,
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _save() async {
    final income = double.tryParse(_incomeController.text);
    if (income == null || income < 0) return;

    final cubit = context.read<FinanceCubit>();
    await cubit.saveBudgetSettings(
      monthlyIncome: income,
      currency: _currency,
      cycleStartDay: 1,
    );

    if (mounted) {
      context.go(AppRoutes.onboardingSpiritual);
    }
  }
}
