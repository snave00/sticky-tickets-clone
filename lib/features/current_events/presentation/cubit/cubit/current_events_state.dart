part of 'current_events_cubit.dart';

@freezed
class CurrentEventsState with _$CurrentEventsState {
  factory CurrentEventsState({
    required CurrentEventsStatus currentEventsStatus,
    required List<EventEntity> currentEvents,
    required EventEntity event,
    final String? successMessage,
    final String? errorMessage,
  }) = _CurrentEventsState;
}

enum CurrentEventsStatus {
  initial,
  getEventsLoading,
  getEventsSuccess,
  getEventLoading,
  getEventSuccess,
  failure,
}
