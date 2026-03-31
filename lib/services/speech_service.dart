import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  SpeechService(this._speechToText);

  final SpeechToText _speechToText;

  Future<bool> initialize() => _speechToText.initialize();

  bool get isListening => _speechToText.isListening;

  Future<void> startListening({
    required void Function(String text) onResult,
    required void Function(String error) onError,
    String localeId = 'en_US',
  }) async {
    await _speechToText.listen(
      localeId: localeId,
      listenMode: ListenMode.confirmation,
      onResult: (result) => onResult(result.recognizedWords),
      onSoundLevelChange: (_) {},
      cancelOnError: false,
      onDevice: false,
      listenFor: const Duration(seconds: 20),
      pauseFor: const Duration(seconds: 3),
    );
  }

  Future<void> stopListening() => _speechToText.stop();
}
