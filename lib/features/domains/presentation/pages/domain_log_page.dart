import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../data/domain_catalog.dart';
import '../../data/domain_log_repository.dart';

class DomainLogPage extends StatefulWidget {
  const DomainLogPage({super.key});

  @override
  State<DomainLogPage> createState() => _DomainLogPageState();
}

class _DomainLogPageState extends State<DomainLogPage> {
  final _durationController = TextEditingController();
  final _metricController = TextEditingController();
  final _noteController = TextEditingController();
  final _repository = DomainLogRepository();
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
      await _repository.addLog(
        domain: domain.routeId,
        durationMinutes: duration,
        metricLabel: domain.metricLabel,
        metricValue: metric,
        note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
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
    final segments = GoRouterState.of(context).uri.pathSegments;
    final domainId = segments.length >= 3 ? segments[2] : 'sports';
    final domain = DomainCatalog.byId(domainId);

    return RizenScaffold(
      appBar: AppBar(
        title: Text('Log ${domain.name}'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(PhosphorIconsBold.microphone),
        label: Text('Voice Log'),
      ),
      body: ListView(
        children: [
          TextField(
            controller: _durationController,
            decoration: InputDecoration(
              labelText: 'Duration (Minutes)',
              hintText: 'e.g. 60',
              prefixIcon: Icon(PhosphorIconsBold.clock),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _metricController,
            decoration: InputDecoration(
              labelText: domain.metricLabel,
              hintText: 'e.g. 10',
              prefixIcon: Icon(PhosphorIconsBold.chartBar),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _noteController,
            decoration: InputDecoration(
              labelText: 'Notes',
              hintText: 'How did the session go?',
              prefixIcon: Icon(PhosphorIconsBold.notepad),
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
