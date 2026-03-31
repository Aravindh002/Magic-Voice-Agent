import 'dart:math' as math;

import 'package:flutter/material.dart';

class WaveOrb extends StatefulWidget {
  const WaveOrb({required this.active, super.key});

  final bool active;

  @override
  State<WaveOrb> createState() => _WaveOrbState();
}

class _WaveOrbState extends State<WaveOrb> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final pulse = widget.active ? (math.sin(_controller.value * math.pi * 2) + 1) / 2 : 0.2;
        return Container(
          width: 140 + (pulse * 22),
          height: 140 + (pulse * 22),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(colors: [Color(0xFF6A5AE0), Color(0xFF00D4FF)]),
            boxShadow: [
              BoxShadow(color: const Color(0xFF6A5AE0).withValues(alpha: 0.4 + pulse * 0.4), blurRadius: 24),
            ],
          ),
          child: const Icon(Icons.graphic_eq, size: 56, color: Colors.white),
        );
      },
    );
  }
}
