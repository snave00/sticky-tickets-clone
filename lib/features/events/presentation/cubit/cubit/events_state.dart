part of 'events_cubit.dart';

@freezed
class EventsState with _$EventsState {
  factory EventsState({
    required EventsStatus eventsStatus,
    required List<EventEntity> events,
    required EventEntity event,
    final String? successMessage,
    final String? errorMessage,
  }) = _EventsState;
}

enum EventsStatus {
  initial,
  getEventsLoading,
  getEventsSuccess,
  getEventLoading,
  getEventSuccess,
  failure,
}
