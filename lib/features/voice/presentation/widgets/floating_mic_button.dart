import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:rizen/core/theme/app_colors.dart';
import '../cubit/voice_cubit.dart';
import '../cubit/voice_state.dart';

class FloatingMicButton extends StatelessWidget {
  const FloatingMicButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VoiceCubit>();

    return BlocBuilder<VoiceCubit, VoiceState>(
      buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        Color backgroundColor;
        Widget icon;
        VoidCallback? onPressed;
        bool isListening = false;

        if (state is VoiceListening) {
          isListening = true;
          backgroundColor = AppColors.accent;
          icon = Icon(
            PhosphorIconsFill.microphoneSlash,
            color: Colors.white,
            size: 28,
          );
          onPressed = cubit.stopListening;
        } else if (state is VoiceProcessing) {
          backgroundColor = AppColors.cardBackground;
          icon = SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        } else if (state is VoiceError) {
          backgroundColor = AppColors.secondaryBackground;
          icon = Icon(
            PhosphorIconsFill.warningCircle,
            color: AppColors.accent,
            size: 28,
          );
          onPressed = cubit.retry;
        } else {
          backgroundColor = AppColors.accent;
          icon = Icon(
            PhosphorIconsFill.microphone,
            color: Colors.white,
            size: 28,
          );
          onPressed = cubit.requestPermissionAndStart;
        }

        return GestureDetector(
          onTap: onPressed,
          child: _PulsingMicButton(
            isListening: isListening,
            backgroundColor: backgroundColor,
            icon: icon,
          ),
        );
      },
    );
  }
}

class _PulsingMicButton extends StatefulWidget {
  const _PulsingMicButton({
    required this.isListening,
    required this.backgroundColor,
    required this.icon,
  });

  final bool isListening;
  final Color backgroundColor;
  final Widget icon;

  @override
  State<_PulsingMicButton> createState() => _PulsingMicButtonState();
}

class _PulsingMicButtonState extends State<_PulsingMicButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 64, end: 90).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(_PulsingMicButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isListening) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final size = widget.isListening ? _animation.value : 64.0;

        return SizedBox(
          width: 90,
          height: 90,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (widget.isListening)
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accent.withValues(alpha: 0.3),
                  ),
                ),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(child: widget.icon),
              ),
            ],
          ),
        );
      },
    );
  }
}
