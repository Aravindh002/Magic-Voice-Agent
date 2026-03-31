import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  TtsService(this._tts);

  final FlutterTts _tts;

  Future<void> configure({double speed = 0.5, double pitch = 1.0}) async {
    await _tts.setSpeechRate(speed);
    await _tts.setPitch(pitch);
  }

  Future<void> speak(String text) async {
    await _tts.stop();
    await _tts.speak(text);
  }
}
