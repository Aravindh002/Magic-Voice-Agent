import 'package:dio/dio.dart';

import '../core/constants/app_constants.dart';
import '../shared/models/assistant_command.dart';

class AiService {
  AiService(this._dio);

  final Dio _dio;

  Future<String> respond(
    AssistantCommand command, {
    String? apiKey,
  }) async {
    if (apiKey == null || apiKey.isEmpty) {
      return _offlineResponse(command);
    }

    final response = await _dio.post(
      'https://api.openai.com/v1/chat/completions',
      options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
      data: {
        'model': AppConstants.openAiModel,
        'messages': [
          {'role': 'system', 'content': 'You are a safe mobile voice assistant.'},
          {'role': 'user', 'content': command.originalText},
        ]
      },
    );

    final text = response.data['choices'][0]['message']['content'] as String?;
    return text?.trim().isNotEmpty == true ? text!.trim() : _offlineResponse(command);
  }

  String _offlineResponse(AssistantCommand command) {
    switch (command.type) {
      case CommandType.openApp:
        return 'Opening app now.';
      case CommandType.openWebsite:
        return 'Opening website now.';
      case CommandType.flashlightToggle:
        return 'I can guide flashlight actions through supported integrations.';
      case CommandType.saveNote:
        return 'I saved your note.';
      case CommandType.readNotes:
        return 'Reading your saved notes.';
      default:
        return 'I heard: ${command.originalText}. How else can I help?';
    }
  }
}
