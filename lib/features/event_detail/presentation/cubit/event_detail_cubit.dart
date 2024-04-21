import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../events/domain/entities/event_entity.dart';
import '../../../events/domain/usecases/get_event_usecase.dart';

part 'event_detail_cubit.freezed.dart';
part 'event_detail_state.dart';

class EventDetailCubit extends Cubit<EventDetailState> {
  final GetEventUseCase getEventUseCase;

  EventDetailCubit({
    required this.getEventUseCase,
  }) : super(EventDetailState(
          eventDetailStatus: EventDetailStatus.initial,
          eventId: '',
          event: EventEntity.empty(),
        ));

  void init({required String eventId}) async {
    emit(state.copyWith(eventId: eventId));
    await getEvent();
  }

  Future<void> getEvent() async {
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
            eventDetailStatus: EventDetailStatus.getEventSuccess,
            event: success,
            errorMessage: '',
          ),
        );
      },
    );
  }

  void _loadingEvent() {
    emit(state.copyWith(
      eventDetailStatus: EventDetailStatus.getEventLoading,
      successMessage: '',
      errorMessage: '',
    ));
  }
}
