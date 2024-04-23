part of 'ticket_cubit.dart';

@freezed
class TicketState with _$TicketState {
  factory TicketState({
    required final ScanTicketStatus scanTicketStatus,
    required final TicketEntity ticketEntity,
    required final String eventId,
    // required final MobileScannerController mobileScannerController,
    required final bool isTorchOn,
    final String? successMessage,
    final String? errorMessage,
  }) = _TicketState;
}

enum ScanTicketStatus {
  initial,
  loading,
  success,
  failure,
}
