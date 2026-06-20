import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../data/domain_catalog.dart';

class DomainLogPage extends StatelessWidget {
  const DomainLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final segments = GoRouterState.of(context).uri.pathSegments;
    final domainId = segments.length >= 3 ? segments[2] : 'sports';
    final domain = DomainCatalog.byId(domainId);

    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
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
            decoration: InputDecoration(
              labelText: 'Duration',
              hintText: 'e.g. 2h 30m',
              prefixIcon: Icon(PhosphorIconsBold.clock),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          TextField(
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
          RizenButton(
            label: 'Save Entry',
            icon: PhosphorIconsBold.check,
            onPressed: () => context.pop(),
          ),
        ],
      ),
    );
  }
}
