import 'package:dio/dio.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../core/permissions/permission_service.dart';
import '../../services/action_executor_service.dart';
import '../../services/ai_service.dart';
import '../../services/confirmation_service.dart';
import '../../services/intent_service.dart';
import '../../services/speech_service.dart';
import '../../services/tts_service.dart';

final speechServiceProvider = Provider((ref) => SpeechService(SpeechToText()));
final ttsServiceProvider = Provider((ref) => TtsService(FlutterTts()));
final intentServiceProvider = Provider((ref) => IntentService());
final actionExecutorServiceProvider = Provider((ref) => ActionExecutorService());
final confirmationServiceProvider = Provider((ref) => ConfirmationService());
final permissionServiceProvider = Provider((ref) => PermissionService());
final aiServiceProvider = Provider((ref) => AiService(Dio()));
