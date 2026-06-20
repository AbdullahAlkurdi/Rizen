import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

class TimeBlock extends Equatable {
  const TimeBlock({
    required this.title,
    required this.domain,
    required this.remainingMinutes,
    required this.icon,
    required this.color,
  });

  final String title;
  final String domain;
  final int remainingMinutes;
  final IconData icon;
  final Color color;

  @override
  List<Object?> get props => [title, domain, remainingMinutes, icon, color];
}

class QuickAction extends Equatable {
  const QuickAction({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;

  @override
  List<Object?> get props => [label, icon, color];
}

class DashboardData {
  static const morningGreeting = 'Good morning';
  static const eveningGreeting = 'Good evening';

  static String greetingForHour(int hour) =>
      hour < 17 ? morningGreeting : eveningGreeting;

  static const activeBlock = TimeBlock(
    title: 'Deep Coding Session',
    domain: 'Coding',
    remainingMinutes: 20,
    icon: PhosphorIconsBold.code,
    color: Color(0xFF60A5FA),
  );

  static const dailyScore = 78;
  static const streakDays = 12;
  static const shadowScore = 23;

  static const quickActions = [
    QuickAction(
      label: 'Log Activity',
      icon: PhosphorIconsBold.plusCircle,
      color: Color(0xFFE94560),
    ),
    QuickAction(
      label: 'Check Habits',
      icon: PhosphorIconsBold.checkCircle,
      color: Color(0xFF4ADE80),
    ),
    QuickAction(
      label: 'Burnout Mode',
      icon: PhosphorIconsBold.firstAid,
      color: Color(0xFFFBBF24),
    ),
    QuickAction(
      label: 'AI Coach',
      icon: PhosphorIconsBold.robot,
      color: Color(0xFF9333EA),
    ),
  ];

  static const upcomingBlocks = [
    ('Maghrib Prayer', 'Spiritual', '45m after Asr'),
    ('Evening Review', 'Reflection', '30m after Maghrib'),
    ('Light Reading', 'Study', 'Before sleep'),
  ];

  static const domainProgress = [
    ('Sports', 0.65, Color(0xFF4ADE80)),
    ('Study', 0.40, Color(0xFF60A5FA)),
    ('Coding', 0.85, Color(0xFF818CF8)),
    ('Spiritual', 0.90, Color(0xFFFBBF24)),
  ];
}
