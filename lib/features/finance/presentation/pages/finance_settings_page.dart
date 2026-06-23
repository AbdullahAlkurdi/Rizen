import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../cubit/finance_cubit.dart';

class FinanceSettingsPage extends StatefulWidget {
  const FinanceSettingsPage({super.key});

  @override
  State<FinanceSettingsPage> createState() => _FinanceSettingsPageState();
}

class _FinanceSettingsPageState extends State<FinanceSettingsPage> {
  final _incomeController = TextEditingController();
  String _currency = 'SAR';
  int _cycleStartDay = 1;
  bool _dailyReviewEnabled = true;
  TimeOfDay _reviewTime = const TimeOfDay(hour: 21, minute: 0);

  static const _currencies = ['SAR', 'USD', 'EUR', 'AED', 'GBP'];

  @override
  void initState() {
    super.initState();
    context.read<FinanceCubit>().loadFinance();
  }

  @override
  void dispose() {
    _incomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Finance Settings',
      subtitle: 'Set monthly income, currency, and cycle start.',
      body: BlocConsumer<FinanceCubit, FinanceState>(
        listener: (context, state) {
          if (state is FinanceLoaded) {
            final income = state.currentCycle?.monthlyIncome;
            if (income != null && _incomeController.text.isEmpty) {
              _incomeController.text = income.toStringAsFixed(2);
              _currency = state.currentCycle!.currency;
              _cycleStartDay = state.currentCycle!.cycleStart.day;
            }
            final schedule = state.dailyReviewSchedule;
            if (schedule != null) {
              _dailyReviewEnabled = schedule.enabled;
              _reviewTime = TimeOfDay(
                hour: schedule.reviewHour,
                minute: schedule.reviewMinute,
              );
            }
          }
          if (state is FinanceError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return ListView(
            children: [
              TextField(
                controller: _incomeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Monthly income'),
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                initialValue: _currency,
                items: _currencies
                    .map(
                      (currency) => DropdownMenuItem(
                        value: currency,
                        child: Text(currency),
                      ),
                    )
                    .toList(),
                onChanged: (value) =>
                    setState(() => _currency = value ?? _currency),
                decoration: const InputDecoration(labelText: 'Currency'),
              ),
              const SizedBox(height: 14),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: _dailyReviewEnabled,
                onChanged: (value) {
                  setState(() => _dailyReviewEnabled = value);
                },
                title: const Text('Daily review prompt'),
                subtitle: Text('Scheduled at ${_reviewTime.format(context)}'),
              ),
              OutlinedButton.icon(
                onPressed: _dailyReviewEnabled
                    ? () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: _reviewTime,
                        );
                        if (picked != null) {
                          setState(() => _reviewTime = picked);
                        }
                      }
                    : null,
                icon: Icon(PhosphorIconsBold.clock),
                label: const Text('Change review time'),
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<int>(
                initialValue: _cycleStartDay,
                items: List.generate(28, (index) => index + 1)
                    .map(
                      (day) =>
                          DropdownMenuItem(value: day, child: Text('Day $day')),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() => _cycleStartDay = value ?? _cycleStartDay);
                },
                decoration: const InputDecoration(labelText: 'Cycle start day'),
              ),
              const SizedBox(height: 24),
              RizenButton(
                label: 'Save Settings',
                icon: PhosphorIconsBold.check,
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
    await context.read<FinanceCubit>().saveBudgetSettings(
      monthlyIncome: income,
      currency: _currency,
      cycleStartDay: _cycleStartDay,
      dailyReviewEnabled: _dailyReviewEnabled,
      reviewHour: _reviewTime.hour,
      reviewMinute: _reviewTime.minute,
    );
    if (mounted) context.pop();
  }
}
