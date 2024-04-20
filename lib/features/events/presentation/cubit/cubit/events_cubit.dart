import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/domain/usecases/usecase.dart';
import '../../../domain/entities/event_entity.dart';
import '../../../domain/usecases/get_event_usecase.dart';
import '../../../domain/usecases/get_events_usecase.dart';

part 'events_cubit.freezed.dart';
part 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  final GetEventUseCase getEventUseCase;
  final GetEventsUseCase getEventsUseCase;

  EventsCubit({
    required this.getEventUseCase,
    required this.getEventsUseCase,
  }) : super(EventsState(
          eventsStatus: EventsStatus.initial,
          events: [],
          event: EventEntity.empty(),
        ));

  void init() async {
    await _getEvents();
  }

  Future<void> _getEvents() async {
    _loadingEvents();
    final result = await getEventsUseCase.call(NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          eventsStatus: EventsStatus.failure,
          errorMessage: failure.errorMessage,
        ),
      ),
      (success) {
        emit(
          state.copyWith(
            eventsStatus: EventsStatus.getEventsSuccess,
            events: success,
            errorMessage: '',
          ),
        );
      },
    );
  }

  Future<void> _getEvent({required String eventId}) async {
    _loadingEvent();
    final result = await getEventUseCase.call(eventId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          eventsStatus: EventsStatus.failure,
          errorMessage: failure.errorMessage,
        ),
      ),
      (success) {
        emit(
          state.copyWith(
            eventsStatus: EventsStatus.getEventSuccess,
            event: success,
            errorMessage: '',
          ),
        );
      },
    );
  }

  void _loadingEvents() {
    emit(state.copyWith(
      eventsStatus: EventsStatus.getEventsLoading,
      successMessage: '',
      errorMessage: '',
    ));
  }

  void _loadingEvent() {
    emit(state.copyWith(
      eventsStatus: EventsStatus.getEventLoading,
      successMessage: '',
      errorMessage: '',
    ));
  }
}
