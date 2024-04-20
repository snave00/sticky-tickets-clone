import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../utils/enums/event_type_enum.dart';
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
          eventType: EventType.all,
          selectedEventIndex: 0,
          event: EventEntity.empty(),
        ));

  void init() async {
    await _getEvents();
  }

  Future<void> _getEvents() async {
    _loadingEvents();
    final result = await getEventsUseCase.call(state.eventType);
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

  void setSelectedEventIndex({required int index}) {
    emit(state.copyWith(selectedEventIndex: _getTopIndex(topIndex: index)));
    // debugPrint('TOP INDEX: ${state.selectedEventIndex}');
  }

  int _getTopIndex({required int topIndex}) {
    final maxIndex = state.events.length - 1;

    // index returns negative value
    if (topIndex < 0) {
      return 0;
    }

    // index returns more than the size of list
    if (topIndex > maxIndex) {
      return maxIndex;
    }

    return topIndex;
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
