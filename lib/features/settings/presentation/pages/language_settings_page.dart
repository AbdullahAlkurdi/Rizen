import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/localization/locale_cubit.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../../generated/app_localizations.dart';
import '../cubit/settings_cubit.dart';

class LanguageSettingsPage extends StatelessWidget {
  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final settings = state is SettingsLoaded ? state : SettingsLoaded();
        final l10n = AppLocalizations.of(context)!;

        return RizenScaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(PhosphorIconsBold.arrowLeft),
              onPressed: () => context.pop(),
            ),
            title: Text(l10n.languageAndPrayer),
          ),
          body: ListView(
            children: [
              Text(l10n.appLanguage, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              _buildLanguageTile(context, l10n, 'English', 'en', settings.language),
              _buildLanguageTile(context, l10n, 'Arabic', 'ar', settings.language),
              const SizedBox(height: 24),
              Text(
                l10n.prayerCalculation,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          PhosphorIconsBold.mapPin,
                          color: AppColors.accent,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          l10n.locationMethod,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.gpsBasedRiyadh,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(PhosphorIconsBold.crosshair),
                      label: Text(l10n.updateLocation),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageTile(BuildContext context, AppLocalizations l10n, String label, String code, String current) {
    final selected = current == code;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassCard(
        onTap: () {
          context.read<SettingsCubit>().setLanguage(code);
          context.read<LocaleCubit>().changeLocale(code);
        },
        borderColor: selected ? AppColors.accent : null,
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? PhosphorIconsFill.checkCircle
                  : PhosphorIconsBold.circle,
              color: selected ? AppColors.accent : AppColors.textMuted,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
