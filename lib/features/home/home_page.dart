import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../shared/providers/assistant_controller.dart';
import '../listening/wave_orb.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(assistantControllerProvider);
    final controller = ref.read(assistantControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Magic Voice Agent'),
        actions: [
          IconButton(onPressed: () => context.push('/history'), icon: const Icon(Icons.history)),
          IconButton(onPressed: () => context.push('/settings'), icon: const Icon(Icons.settings)),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF0F1020), Color(0xFF1F1557)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      WaveOrb(active: state.isListening || state.isProcessing),
                      const SizedBox(height: 20),
                      Text(state.transcript.isEmpty ? 'Tap the mic and speak' : state.transcript, style: const TextStyle(color: Colors.white)),
                      const SizedBox(height: 12),
                      Text(state.lastResponse, style: const TextStyle(color: Colors.white70)),
                      if (state.error != null) ...[
                        const SizedBox(height: 8),
                        Text(state.error!, style: const TextStyle(color: Colors.redAccent)),
                      ],
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          FilledButton.icon(
                            onPressed: state.isListening ? null : controller.startListening,
                            icon: const Icon(Icons.mic),
                            label: const Text('Start'),
                          ),
                          OutlinedButton.icon(
                            onPressed: state.isListening ? controller.stopListening : null,
                            icon: const Icon(Icons.stop),
                            label: const Text('Stop'),
                          ),
                          FilledButton.tonalIcon(
                            onPressed: () => controller.processTranscript(context),
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Run Command'),
                          ),
                          TextButton.icon(
                            onPressed: () => controller.repeatLastCommand(context),
                            icon: const Icon(Icons.repeat),
                            label: const Text('Repeat Last'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
