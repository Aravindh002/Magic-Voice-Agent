import '../shared/models/assistant_command.dart';

class IntentService {
  AssistantCommand parse(String input) {
    final text = input.toLowerCase().trim();

    if (text.startsWith('open ') && text.contains('http')) {
      return AssistantCommand(
        originalText: input,
        type: CommandType.openWebsite,
        payload: {'url': text.replaceFirst('open ', '')},
      );
    }
    if (text.startsWith('open ')) {
      return AssistantCommand(
        originalText: input,
        type: CommandType.openApp,
        payload: {'app': text.replaceFirst('open ', '')},
      );
    }
    if (text.contains('flashlight')) {
      return AssistantCommand(
        originalText: input,
        type: CommandType.flashlightToggle,
      );
    }
    if (text.contains('call ')) {
      return AssistantCommand(
        originalText: input,
        type: CommandType.callPhone,
        payload: {'number': text.replaceFirst('call ', '')},
        requiresConfirmation: true,
      );
    }
    if (text.contains('sms ') || text.contains('message ')) {
      return AssistantCommand(
        originalText: input,
        type: CommandType.sendSms,
        requiresConfirmation: true,
      );
    }
    if (text.startsWith('save note')) {
      return AssistantCommand(
        originalText: input,
        type: CommandType.saveNote,
        payload: {'text': input.replaceFirst(RegExp(r'(?i)save note'), '').trim()},
      );
    }
    if (text.contains('read notes')) {
      return AssistantCommand(originalText: input, type: CommandType.readNotes);
    }
    return AssistantCommand(originalText: input, type: CommandType.chat);
  }
}
