import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../shared/providers/assistant_controller.dart';

class CommandHistoryPage extends ConsumerWidget {
  const CommandHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(commandHistoryProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Command History')),
      body: ListView.separated(
        itemCount: history.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (_, i) {
          final item = history[i];
          return ListTile(
            title: Text(item.command.originalText),
            subtitle: Text(item.response, maxLines: 2, overflow: TextOverflow.ellipsis),
            trailing: Text(DateFormat.Hm().format(item.timestamp)),
          );
        },
      ),
    );
  }
}
