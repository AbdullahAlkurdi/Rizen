import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../cubit/domain_logs_cubit.dart';
import '../../data/domain_catalog.dart';

class DomainLogPage extends StatefulWidget {
  final String domainId;

  const DomainLogPage({super.key, required this.domainId});

  @override
  State<DomainLogPage> createState() => _DomainLogPageState();
}

class _DomainLogPageState extends State<DomainLogPage> {
  final _durationController = TextEditingController();
  final _metricController = TextEditingController();
  final _noteController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _durationController.dispose();
    _metricController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _saveLog(DomainInfo domain) async {
    final duration = int.tryParse(_durationController.text) ?? 0;
    final metric = num.tryParse(_metricController.text) ?? 0;

    if (duration <= 0 && metric <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter duration or metric value')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await context.read<DomainLogsCubit>().addLog(
            domainId: domain.routeId,
            duration: duration,
            notes:
                _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
            metricLabel: domain.metricLabel,
            metricValue: metric.toDouble(),
          );
      if (mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${domain.name} session logged!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final domain = DomainCatalog.byId(widget.domainId);

    return RizenScaffold(
      appBar: AppBar(title: Text('Log ${domain.name}')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(PhosphorIconsBold.microphone),
        label: const Text('Voice Log'),
      ),
      body: ListView(
        children: [
          TextField(
            controller: _durationController,
            decoration: InputDecoration(
              labelText: 'Duration (Minutes)',
              hintText: 'e.g. 60',
              prefixIcon: const Icon(PhosphorIconsBold.clock),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _metricController,
            decoration: InputDecoration(
              labelText: domain.metricLabel,
              hintText: 'e.g. 10',
              prefixIcon: const Icon(PhosphorIconsBold.chartBar),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _noteController,
            decoration: InputDecoration(
              labelText: 'Notes',
              hintText: 'How did the session go?',
              prefixIcon: const Icon(PhosphorIconsBold.notepad),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.glassFill,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(PhosphorIconsBold.star, color: domain.color, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Intensity: Normal',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                TextButton(onPressed: () {}, child: const Text('Adjust')),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : RizenButton(
                  label: 'Save Entry',
                  icon: PhosphorIconsBold.check,
                  onPressed: () => _saveLog(domain),
                ),
        ],
      ),
    );
  }
}
