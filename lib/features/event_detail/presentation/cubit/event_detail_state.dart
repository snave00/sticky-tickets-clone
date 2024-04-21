part of 'event_detail_cubit.dart';

@freezed
class EventDetailState with _$EventDetailState {
  factory EventDetailState({
    required EventDetailStatus eventDetailStatus,
    required String eventId,
    required EventEntity event,
    final String? successMessage,
    final String? errorMessage,
  }) = _EventDetailState;
}

enum EventDetailStatus {
  initial,
  getEventLoading,
  getEventSuccess,
  failure,
}
