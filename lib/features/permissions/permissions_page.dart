import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../shared/providers/service_providers.dart';

class PermissionsPage extends ConsumerWidget {
  const PermissionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permissions')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Magic Voice Agent requests permissions only when needed. No hidden monitoring.',
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () async {
                await ref.read(permissionServiceProvider).ensureMicrophonePermission();
                if (context.mounted) context.go('/home');
              },
              icon: const Icon(Icons.mic),
              label: const Text('Grant & Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
