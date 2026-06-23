import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';

class PrayerSettingsPage extends StatefulWidget {
  const PrayerSettingsPage({super.key});

  @override
  State<PrayerSettingsPage> createState() => _PrayerSettingsPageState();
}

class _PrayerSettingsPageState extends State<PrayerSettingsPage> {
  String _method = 'Muslim World League';
  bool _fajrNotification = true;
  bool _dhuhrNotification = true;
  bool _asrNotification = true;
  bool _maghribNotification = true;
  bool _ishaNotification = true;

  static const _methods = [
    'Muslim World League',
    'Umm Al-Qura',
    'Egyptian General Authority',
    'ISNA',
    'MWL',
  ];

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Prayer Settings',
      subtitle: 'Calculation method and notification preferences.',
      body: ListView(
        children: [
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Calculation Method',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: _method,
                  items: _methods
                      .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                      .toList(),
                  onChanged: (v) => setState(() => _method = v ?? _method),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Prayer Notifications',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          SwitchListTile(
            title: const Text('Fajr'),
            value: _fajrNotification,
            onChanged: (v) => setState(() => _fajrNotification = v),
          ),
          SwitchListTile(
            title: const Text('Dhuhr'),
            value: _dhuhrNotification,
            onChanged: (v) => setState(() => _dhuhrNotification = v),
          ),
          SwitchListTile(
            title: const Text('Asr'),
            value: _asrNotification,
            onChanged: (v) => setState(() => _asrNotification = v),
          ),
          SwitchListTile(
            title: const Text('Maghrib'),
            value: _maghribNotification,
            onChanged: (v) => setState(() => _maghribNotification = v),
          ),
          SwitchListTile(
            title: const Text('Isha'),
            value: _ishaNotification,
            onChanged: (v) => setState(() => _ishaNotification = v),
          ),
          const SizedBox(height: 24),
          RizenButton(
            label: 'Save Settings',
            icon: PhosphorIconsBold.check,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
