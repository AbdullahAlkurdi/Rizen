import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF16213E),
      highlightColor: const Color(0xFF0F3460),
      period: const Duration(milliseconds: 1200),
      child: child,
    );
  }
}

class SkeletonLine extends StatelessWidget {
  const SkeletonLine({
    super.key,
    this.width = double.infinity,
    this.height = 16,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFF16213E),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key, this.height = 80});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFF16213E),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

class SkeletonAvatar extends StatelessWidget {
  const SkeletonAvatar({super.key, this.radius = 24});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          color: const Color(0xFF16213E),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class SkeletonListTile extends StatelessWidget {
  const SkeletonListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SkeletonAvatar(radius: 20),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SkeletonLine(width: double.infinity, height: 16),
                SizedBox(height: 8),
                SkeletonLine(width: 160, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SkeletonChip extends StatelessWidget {
  const SkeletonChip({super.key, this.width = 80});

  final double width;

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      child: Container(
        width: width,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xFF16213E),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}

class SkeletonBarChart extends StatelessWidget {
  const SkeletonBarChart({super.key, this.barCount = 5});

  final int barCount;

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(barCount, (index) {
          final heights = [50, 70, 40, 90, 55, 75, 35];
          final h = heights[index % heights.length].toDouble();
          return Container(
            width: 20,
            height: h,
            decoration: BoxDecoration(
              color: const Color(0xFF16213E),
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
      ),
    );
  }
}

class SkeletonMiniBar extends StatelessWidget {
  const SkeletonMiniBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      child: Container(
        width: double.infinity,
        height: 3,
        decoration: BoxDecoration(
          color: const Color(0xFF16213E),
          borderRadius: BorderRadius.circular(1.5),
        ),
      ),
    );
  }
}
