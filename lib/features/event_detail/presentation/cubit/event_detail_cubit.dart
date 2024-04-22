import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../events/domain/entities/event_entity.dart';
import '../../../events/domain/usecases/get_checked_in_guests_total_usecase.dart';
import '../../../events/domain/usecases/get_event_usecase.dart';
import '../../../events/domain/usecases/get_guests_total_usecase.dart';
import '../../../events/domain/usecases/get_tickets_usecase.dart';
import '../../../ticket/domain/entities/ticket_entity.dart';
import '../../../ticket/domain/params/scan_ticket_params.dart';
import '../../../ticket/domain/usecases/check_in_ticket_usecase.dart';
import '../../../ticket/domain/usecases/check_out_ticket_usecase.dart';

part 'event_detail_cubit.freezed.dart';
part 'event_detail_state.dart';

class EventDetailCubit extends Cubit<EventDetailState> {
  final GetEventUseCase getEventUseCase;
  final GetTicketsUseCase getTicketsUseCase;
  final GetGuestsTotalUseCase getGuestsTotalUseCase;
  final GetCheckedInGuestsTotalUseCase getCheckedInGuestsTotalUseCase;
  final CheckInTicketUseCase checkInTicketUseCase;
  final CheckOutTicketUseCase checkOutTicketUseCase;

  EventDetailCubit({
    required this.getEventUseCase,
    required this.getTicketsUseCase,
    required this.getGuestsTotalUseCase,
    required this.getCheckedInGuestsTotalUseCase,
    required this.checkInTicketUseCase,
    required this.checkOutTicketUseCase,
  }) : super(EventDetailState(
          eventDetailStatus: EventDetailStatus.initial,
          getTicketsStatus: GetTicketsStatus.initial,
          getGuestsTotalStatus: GetGuestsTotalStatus.initial,
          getCheckedInGuestsTotalStatus: GetCheckedInGuestsTotalStatus.initial,
          checkedInTicketStatus: CheckedInTicketStatus.initial,
          checkedOutTicketStatus: CheckedOutTicketStatus.initial,
          eventId: '',
          event: EventEntity.empty(),
          filteredTickets: [],
          guestsTotal: 0,
          checkedInGuestsTotal: 0,
        ));

  void init({required String eventId}) async {
    emit(state.copyWith(eventId: eventId));
    await refresh();
  }

  Future<void> refresh() async {
    _resetCheckInOutStatus();
    await _getEvent();
    _getTickets();
    await _getGuestsTotal();
    await _getCheckedInGuestsTotal();
  }

  Future<void> _getEvent() async {
    _loadingEvent();
    final result = await getEventUseCase.call(state.eventId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          eventDetailStatus: EventDetailStatus.failure,
          errorMessage: failure.errorMessage,
        ),
      ),
      (success) {
        emit(
          state.copyWith(
            eventDetailStatus: EventDetailStatus.success,
            event: success,
            errorMessage: '',
          ),
        );
      },
    );
  }

  Future<void> _getTickets() async {
    _loadingTickets();
    final result = await getTicketsUseCase.call(state.eventId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          getTicketsStatus: GetTicketsStatus.failure,
          errorMessage: failure.errorMessage,
        ),
      ),
      (success) {
        emit(
          state.copyWith(
            getTicketsStatus: GetTicketsStatus.success,
            filteredTickets: success,
            errorMessage: '',
          ),
        );
      },
    );
  }

  Future<void> _getGuestsTotal() async {
    _loadingGuestsTotal();
    final result = await getGuestsTotalUseCase.call(state.eventId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          getGuestsTotalStatus: GetGuestsTotalStatus.failure,
          errorMessage: failure.errorMessage,
        ),
      ),
      (success) {
        emit(
          state.copyWith(
            getGuestsTotalStatus: GetGuestsTotalStatus.success,
            guestsTotal: success,
            errorMessage: '',
          ),
        );
      },
    );
  }

  Future<void> _getCheckedInGuestsTotal() async {
    _loadingCheckedInGuestsTotal();
    final result = await getCheckedInGuestsTotalUseCase.call(state.eventId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          getCheckedInGuestsTotalStatus: GetCheckedInGuestsTotalStatus.failure,
          errorMessage: failure.errorMessage,
        ),
      ),
      (success) {
        emit(
          state.copyWith(
            getCheckedInGuestsTotalStatus:
                GetCheckedInGuestsTotalStatus.success,
            checkedInGuestsTotal: success,
            errorMessage: '',
          ),
        );
      },
    );
  }

  Future<void> checkInTicket({required String ticketId}) async {
    _loadingCheckedIn();
    final result = await checkInTicketUseCase.call(
      ScanTicketParams(
        ticketId: ticketId,
        eventId: state.eventId,
      ),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          checkedInTicketStatus: CheckedInTicketStatus.failure,
          errorMessage: failure.errorMessage,
        ),
      ),
      (success) async {
        emit(
          state.copyWith(
            checkedInTicketStatus: CheckedInTicketStatus.success,
            errorMessage: '',
          ),
        );

        await refresh();
      },
    );
  }

  Future<void> checkOutTicket({required String ticketId}) async {
    _loadingCheckedOut();
    final result = await checkOutTicketUseCase.call(ticketId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          checkedOutTicketStatus: CheckedOutTicketStatus.failure,
          errorMessage: failure.errorMessage,
        ),
      ),
      (success) async {
        emit(
          state.copyWith(
            checkedOutTicketStatus: CheckedOutTicketStatus.success,
            errorMessage: '',
          ),
        );

        await refresh();
      },
    );
  }

  void _resetCheckInOutStatus() {
    emit(
      state.copyWith(
        checkedInTicketStatus: CheckedInTicketStatus.initial,
        checkedOutTicketStatus: CheckedOutTicketStatus.initial,
      ),
    );
  }

  void _loadingEvent() {
    emit(state.copyWith(
      eventDetailStatus: EventDetailStatus.loading,
      successMessage: '',
      errorMessage: '',
    ));
  }

  void _loadingTickets() {
    emit(state.copyWith(
      getTicketsStatus: GetTicketsStatus.loading,
      successMessage: '',
      errorMessage: '',
    ));
  }

  void _loadingGuestsTotal() {
    emit(state.copyWith(
      getGuestsTotalStatus: GetGuestsTotalStatus.loading,
      successMessage: '',
      errorMessage: '',
    ));
  }

  void _loadingCheckedInGuestsTotal() {
    emit(state.copyWith(
      getCheckedInGuestsTotalStatus: GetCheckedInGuestsTotalStatus.loading,
      successMessage: '',
      errorMessage: '',
    ));
  }

  void _loadingCheckedIn() {
    emit(state.copyWith(
      checkedInTicketStatus: CheckedInTicketStatus.loading,
      successMessage: '',
      errorMessage: '',
    ));
  }

  void _loadingCheckedOut() {
    emit(state.copyWith(
      checkedOutTicketStatus: CheckedOutTicketStatus.loading,
      successMessage: '',
      errorMessage: '',
    ));
  }
}
