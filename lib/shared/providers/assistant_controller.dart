import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/models/assistant_state.dart';
import '../../shared/models/command_history_item.dart';
import 'service_providers.dart';

final assistantControllerProvider =
    StateNotifierProvider<AssistantController, AssistantState>(
  (ref) => AssistantController(ref),
);

final commandHistoryProvider = StateProvider<List<CommandHistoryItem>>((ref) => []);

class AssistantController extends StateNotifier<AssistantState> {
  AssistantController(this._ref) : super(const AssistantState()) {
    _ref.read(ttsServiceProvider).configure();
  }

  final Ref _ref;

  Future<void> startListening() async {
    state = state.copyWith(isProcessing: false, clearError: true);
    final granted = await _ref.read(permissionServiceProvider).ensureMicrophonePermission();
    if (!granted) {
      state = state.copyWith(error: 'Microphone permission denied.');
      return;
    }

    final speech = _ref.read(speechServiceProvider);
    final ready = await speech.initialize();
    if (!ready) {
      state = state.copyWith(error: 'Speech engine initialization failed.');
      return;
    }

    state = state.copyWith(isListening: true);
    await speech.startListening(
      onResult: (text) => state = state.copyWith(transcript: text),
      onError: (error) => state = state.copyWith(error: error, isListening: false),
    );
  }

  Future<void> stopListening() async {
    await _ref.read(speechServiceProvider).stopListening();
    state = state.copyWith(isListening: false);
  }

  Future<void> processTranscript(BuildContext context, {String? openAiApiKey}) async {
    final text = state.transcript.trim();
    if (text.isEmpty) return;

    state = state.copyWith(isProcessing: true, clearError: true);
    final command = _ref.read(intentServiceProvider).parse(text);

    if (command.requiresConfirmation) {
      final approved = await _ref.read(confirmationServiceProvider).requestConfirmation(
            context,
            title: 'Confirm sensitive action',
            message: 'Do you want to proceed with: "$text"?',
          );
      if (!approved) {
        state = state.copyWith(
          isProcessing: false,
          lastResponse: 'Canceled for safety.',
        );
        return;
      }
    }

    final aiText = await _ref.read(aiServiceProvider).respond(command, apiKey: openAiApiKey);
    final execution = await _ref.read(actionExecutorServiceProvider).execute(command);
    final reply = '$aiText\n$execution';

    _ref.read(ttsServiceProvider).speak(reply);

    final history = _ref.read(commandHistoryProvider);
    _ref.read(commandHistoryProvider.notifier).state = [
      CommandHistoryItem(command: command, response: reply),
      ...history,
    ];

    state = state.copyWith(isProcessing: false, lastResponse: reply);
  }

  void repeatLastCommand(BuildContext context) {
    final history = _ref.read(commandHistoryProvider);
    if (history.isNotEmpty) {
      state = state.copyWith(transcript: history.first.command.originalText);
      processTranscript(context);
    }
  }
}
