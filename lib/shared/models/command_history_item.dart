import 'assistant_command.dart';

class CommandHistoryItem {
  CommandHistoryItem({
    required this.command,
    required this.response,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  final AssistantCommand command;
  final String response;
  final DateTime timestamp;
}
