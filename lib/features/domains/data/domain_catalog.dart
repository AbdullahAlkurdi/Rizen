import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';

enum LifeDomain { sports, study, work, coding, cooking, spiritual, custom }

class DomainInfo {
  const DomainInfo({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.weeklyHours,
    required this.streak,
    required this.progress,
    required this.metricLabel,
  });

  final LifeDomain id;
  final String name;
  final String subtitle;
  final IconData icon;
  final Color color;
  final double weeklyHours;
  final int streak;
  final double progress;
  final String metricLabel;

  String get routeId => id.name;
}

abstract final class DomainCatalog {
  static const all = [
    DomainInfo(
      id: LifeDomain.sports,
      name: 'Sports',
      subtitle: 'Training, cardio, and recovery',
      icon: PhosphorIconsBold.barbell,
      color: Color(0xFF4ADE80),
      weeklyHours: 4.5,
      streak: 8,
      progress: 0.65,
      metricLabel: 'km run',
    ),
    DomainInfo(
      id: LifeDomain.study,
      name: 'Study',
      subtitle: 'Reading, courses, and deep learning',
      icon: PhosphorIconsBold.bookOpen,
      color: Color(0xFF60A5FA),
      weeklyHours: 6.0,
      streak: 5,
      progress: 0.40,
      metricLabel: 'pages read',
    ),
    DomainInfo(
      id: LifeDomain.work,
      name: 'Work',
      subtitle: 'Professional tasks and focus blocks',
      icon: PhosphorIconsBold.briefcase,
      color: Color(0xFF38BDF8),
      weeklyHours: 32.0,
      streak: 14,
      progress: 0.72,
      metricLabel: 'focus sessions',
    ),
    DomainInfo(
      id: LifeDomain.coding,
      name: 'Coding',
      subtitle: 'Projects, commits, and skill building',
      icon: PhosphorIconsBold.code,
      color: Color(0xFF818CF8),
      weeklyHours: 12.0,
      streak: 11,
      progress: 0.85,
      metricLabel: 'commits',
    ),
    DomainInfo(
      id: LifeDomain.cooking,
      name: 'Cooking & Nutrition',
      subtitle: 'Meals, macros, and hydration',
      icon: PhosphorIconsBold.cookingPot,
      color: Color(0xFFFB923C),
      weeklyHours: 5.0,
      streak: 6,
      progress: 0.55,
      metricLabel: 'meals cooked',
    ),
    DomainInfo(
      id: LifeDomain.spiritual,
      name: 'Spiritual',
      subtitle: 'Prayer, Quran, and reflection',
      icon: PhosphorIconsBold.moonStars,
      color: Color(0xFFFBBF24),
      weeklyHours: 7.0,
      streak: 21,
      progress: 0.90,
      metricLabel: 'Quran pages',
    ),
    DomainInfo(
      id: LifeDomain.custom,
      name: 'Custom Domain',
      subtitle: 'Your personal life pillar',
      icon: PhosphorIconsBold.star,
      color: AppColors.accent,
      weeklyHours: 3.0,
      streak: 3,
      progress: 0.30,
      metricLabel: 'custom unit',
    ),
  ];

  static DomainInfo byId(String id) =>
      all.firstWhere((d) => d.routeId == id, orElse: () => all.last);
}
