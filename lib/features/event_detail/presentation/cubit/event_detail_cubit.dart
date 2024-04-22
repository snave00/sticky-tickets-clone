import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../events/domain/entities/event_entity.dart';
import '../../../events/domain/usecases/get_checked_in_guests_total_usecase.dart';
import '../../../events/domain/usecases/get_event_usecase.dart';
import '../../../events/domain/usecases/get_guests_total_usecase.dart';
import '../../../events/domain/usecases/get_tickets_usecase.dart';
import '../../../ticket/domain/entities/ticket_entity.dart';

part 'event_detail_cubit.freezed.dart';
part 'event_detail_state.dart';

class EventDetailCubit extends Cubit<EventDetailState> {
  final GetEventUseCase getEventUseCase;
  final GetTicketsUseCase getTicketsUseCase;
  final GetGuestsTotalUseCase getGuestsTotalUseCase;
  final GetCheckedInGuestsTotalUseCase getCheckedInGuestsTotalUseCase;

  EventDetailCubit({
    required this.getEventUseCase,
    required this.getTicketsUseCase,
    required this.getGuestsTotalUseCase,
    required this.getCheckedInGuestsTotalUseCase,
  }) : super(EventDetailState(
          eventDetailStatus: EventDetailStatus.initial,
          getTicketsStatus: GetTicketsStatus.initial,
          getGuestsTotalStatus: GetGuestsTotalStatus.initial,
          getCheckedInGuestsTotalStatus: GetCheckedInGuestsTotalStatus.initial,
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
}
