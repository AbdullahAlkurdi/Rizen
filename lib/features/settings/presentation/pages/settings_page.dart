import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/locale_cubit.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../../generated/app_localizations.dart';
import '../cubit/settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final settings = state is SettingsLoaded ? state : SettingsLoaded();

        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            final themeMode = themeState is ThemeLoaded ? themeState.mode : ThemeMode.system;

            return RizenScaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                ),
                title: Text(AppLocalizations.of(context)!.settings),
              ),
              body: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text(
                    AppLocalizations.of(context)!.appearance,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.theme, style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _ThemeButton(
                              label: AppLocalizations.of(context)!.dark,
                              isSelected: themeMode == ThemeMode.dark,
                              onTap: () => context.read<ThemeCubit>().setDark(),
                            ),
                            const SizedBox(width: 8),
                            _ThemeButton(
                              label: AppLocalizations.of(context)!.light,
                              isSelected: themeMode == ThemeMode.light,
                              onTap: () => context.read<ThemeCubit>().setLight(),
                            ),
                            const SizedBox(width: 8),
                            _ThemeButton(
                              label: AppLocalizations.of(context)!.system,
                              isSelected: themeMode == ThemeMode.system,
                              onTap: () => context.read<ThemeCubit>().setSystem(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(AppLocalizations.of(context)!.language, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.appLanguage,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _LanguageButton(
                              label: 'EN',
                              isSelected: settings.language == 'en',
                              onTap: () {
                                context.read<SettingsCubit>().setLanguage('en');
                                context.read<LocaleCubit>().changeLocale('en');
                              },
                            ),
                            const SizedBox(width: 8),
                            _LanguageButton(
                              label: 'AR',
                              isSelected: settings.language == 'ar',
                              onTap: () {
                                context.read<SettingsCubit>().setLanguage('ar');
                                context.read<LocaleCubit>().changeLocale('ar');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.notifications,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  GlassCard(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.enableNotifications,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Switch(
                          value: settings.notificationsEnabled,
                          activeThumbColor: AppColors.accent,
                          onChanged: (v) =>
                              context.read<SettingsCubit>().setNotificationsEnabled(v),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(AppLocalizations.of(context)!.currency, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.preferredCurrency,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          children: [
                            _CurrencyButton(
                              label: 'USD',
                              isSelected: settings.currency == 'USD',
                              onTap: () => context.read<SettingsCubit>().setCurrency('USD'),
                            ),
                            _CurrencyButton(
                              label: 'EUR',
                              isSelected: settings.currency == 'EUR',
                              onTap: () => context.read<SettingsCubit>().setCurrency('EUR'),
                            ),
                            _CurrencyButton(
                              label: 'GBP',
                              isSelected: settings.currency == 'GBP',
                              onTap: () => context.read<SettingsCubit>().setCurrency('GBP'),
                            ),
                            _CurrencyButton(
                              label: 'SAR',
                              isSelected: settings.currency == 'SAR',
                              onTap: () => context.read<SettingsCubit>().setCurrency('SAR'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GlassCard(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.appVersion,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          '1.0.0',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Help & Tutorials',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  GlassCard(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              PhosphorIconsBold.question,
                              color: AppColors.accent,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Help & Tutorials',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        Icon(
                          PhosphorIconsBold.caretRight,
                          color: AppColors.textMuted,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _ThemeButton extends StatelessWidget {
  const _ThemeButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.accent.withValues(alpha: 0.2)
                : Colors.transparent,
            border: Border.all(
              color: isSelected ? AppColors.accent : AppColors.glassBorder,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.accent : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.accent.withValues(alpha: 0.2)
                : Colors.transparent,
            border: Border.all(
              color: isSelected ? AppColors.accent : AppColors.glassBorder,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.accent : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CurrencyButton extends StatelessWidget {
  const _CurrencyButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accent.withValues(alpha: 0.2)
              : AppColors.glassFill,
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.glassBorder,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.accent : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}