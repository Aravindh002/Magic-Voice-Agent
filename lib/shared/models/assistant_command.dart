enum CommandType {
  openApp,
  openWebsite,
  flashlightToggle,
  openSettings,
  setReminder,
  saveNote,
  readNotes,
  callPhone,
  sendSms,
  chat,
  unknown,
}

class AssistantCommand {
  AssistantCommand({
    required this.originalText,
    required this.type,
    this.payload,
    this.requiresConfirmation = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  final String originalText;
  final CommandType type;
  final Map<String, dynamic>? payload;
  final bool requiresConfirmation;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
        'originalText': originalText,
        'type': type.name,
        'payload': payload,
        'requiresConfirmation': requiresConfirmation,
        'createdAt': createdAt.toIso8601String(),
      };

  factory AssistantCommand.fromJson(Map<String, dynamic> json) => AssistantCommand(
        originalText: json['originalText'] as String,
        type: CommandType.values.firstWhere(
          (e) => e.name == json['type'],
          orElse: () => CommandType.unknown,
        ),
        payload: json['payload'] as Map<String, dynamic>?,
        requiresConfirmation: json['requiresConfirmation'] as bool? ?? false,
        createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      );
}
