class AssistantState {
  const AssistantState({
    this.isListening = false,
    this.isProcessing = false,
    this.transcript = '',
    this.lastResponse = 'How can I help you today?',
    this.error,
  });

  final bool isListening;
  final bool isProcessing;
  final String transcript;
  final String lastResponse;
  final String? error;

  AssistantState copyWith({
    bool? isListening,
    bool? isProcessing,
    String? transcript,
    String? lastResponse,
    String? error,
    bool clearError = false,
  }) {
    return AssistantState(
      isListening: isListening ?? this.isListening,
      isProcessing: isProcessing ?? this.isProcessing,
      transcript: transcript ?? this.transcript,
      lastResponse: lastResponse ?? this.lastResponse,
      error: clearError ? null : (error ?? this.error),
    );
  }
}
