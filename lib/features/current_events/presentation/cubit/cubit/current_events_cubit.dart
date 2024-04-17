import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/domain/usecases/usecase.dart';
import '../../../domain/entities/event_entity.dart';
import '../../../domain/usecases/get_event_usecase.dart';
import '../../../domain/usecases/get_events_usecase.dart';

part 'current_events_cubit.freezed.dart';
part 'current_events_state.dart';

class CurrentEventsCubit extends Cubit<CurrentEventsState> {
  final GetEventUseCase getEventUseCase;
  final GetEventsUseCase getEventsUseCase;

  CurrentEventsCubit({
    required this.getEventUseCase,
    required this.getEventsUseCase,
  }) : super(CurrentEventsState(
          currentEventsStatus: CurrentEventsStatus.initial,
          currentEvents: [],
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
          currentEventsStatus: CurrentEventsStatus.failure,
          errorMessage: failure.errorMessage,
        ),
      ),
      (success) {
        emit(
          state.copyWith(
            currentEventsStatus: CurrentEventsStatus.getEventsSuccess,
            currentEvents: success,
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
          currentEventsStatus: CurrentEventsStatus.failure,
          errorMessage: failure.errorMessage,
        ),
      ),
      (success) {
        emit(
          state.copyWith(
            currentEventsStatus: CurrentEventsStatus.getEventSuccess,
            event: success,
            errorMessage: '',
          ),
        );
      },
    );
  }

  void _loadingEvents() {
    emit(state.copyWith(
      currentEventsStatus: CurrentEventsStatus.getEventsLoading,
      successMessage: '',
      errorMessage: '',
    ));
  }

  void _loadingEvent() {
    emit(state.copyWith(
      currentEventsStatus: CurrentEventsStatus.getEventLoading,
      successMessage: '',
      errorMessage: '',
    ));
  }
}
