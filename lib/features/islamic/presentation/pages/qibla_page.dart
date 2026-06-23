import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../cubit/prayer_times_cubit.dart';

class QiblaPage extends StatefulWidget {
  const QiblaPage({super.key});

  @override
  State<QiblaPage> createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {
  double _qiblaBearing = 0;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadQiblaBearing();
  }

  Future<void> _loadQiblaBearing() async {
    final state = context.read<PrayerTimesCubit>().state;
    if (state is PrayerTimesLoaded) {
      final bearing = await context
          .read<PrayerTimesCubit>()
          .repository
          .getQiblaBearing(
            lat: state.cache.latitude,
            lng: state.cache.longitude,
          );
      if (mounted) {
        setState(() {
          _qiblaBearing = bearing;
          _loaded = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(title: const Text('Qibla Compass')),
      body: Center(
        child: !_loaded
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIconsBold.compass,
                    color: AppColors.accent,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Qibla bearing',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_qiblaBearing.toStringAsFixed(1)} deg',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: 240,
                    height: 240,
                    child: CustomPaint(
                      painter: _CompassPainter(qiblaBearing: _qiblaBearing),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _CompassPainter extends CustomPainter {
  _CompassPainter({required this.qiblaBearing});

  final double qiblaBearing;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20;

    final circlePaint = Paint()
      ..color = AppColors.cardBackground
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, circlePaint);

    final strokePaint = Paint()
      ..color = AppColors.glassBorder
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius, strokePaint);

    final needleAngle = qiblaBearing * pi / 180;
    final needleLength = radius * 0.8;
    final needlePaint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final needleEnd = Offset(
      center.dx + needleLength * sin(needleAngle),
      center.dy - needleLength * cos(needleAngle),
    );
    canvas.drawLine(center, needleEnd, needlePaint);
  }

  @override
  bool shouldRepaint(covariant _CompassPainter oldDelegate) {
    return oldDelegate.qiblaBearing != qiblaBearing;
  }
}
