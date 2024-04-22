part of 'event_detail_cubit.dart';

@freezed
class EventDetailState with _$EventDetailState {
  factory EventDetailState({
    required EventDetailStatus eventDetailStatus,
    required GetTicketsStatus getTicketsStatus,
    required GetGuestsTotalStatus getGuestsTotalStatus,
    required GetCheckedInGuestsTotalStatus getCheckedInGuestsTotalStatus,
    required CheckedInTicketStatus checkedInTicketStatus,
    required CheckedOutTicketStatus checkedOutTicketStatus,
    required String eventId,
    required EventEntity event,
    required List<TicketEntity> filteredTickets,
    required int guestsTotal,
    required int checkedInGuestsTotal,
    final String? successMessage,
    final String? errorMessage,
  }) = _EventDetailState;
}

enum EventDetailStatus {
  initial,
  loading,
  success,
  failure,
}

enum GetTicketsStatus {
  initial,
  loading,
  success,
  failure,
}

enum GetGuestsTotalStatus {
  initial,
  loading,
  success,
  failure,
}

enum GetCheckedInGuestsTotalStatus {
  initial,
  loading,
  success,
  failure,
}

enum CheckedInTicketStatus {
  initial,
  loading,
  success,
  failure,
}

enum CheckedOutTicketStatus {
  initial,
  loading,
  success,
  failure,
}
