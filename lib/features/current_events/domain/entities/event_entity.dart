import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../utils/helpers/shared/date_time_helper.dart';
import '../../data/models/remote_models/event_model.dart';

part 'event_entity.freezed.dart';
part 'event_entity.g.dart';

@freezed
class EventEntity with _$EventEntity {
  EventEntity._();

  factory EventEntity({
    required final String eventId,
    required final String eventName,
    required final DateTime date,
    required final String image,
    required final String checkedInTotal,
    required final String guestTotal,
    required final List<String> guestList,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _EventEntity;

  factory EventEntity.empty() {
    return EventEntity(
      eventId: '',
      eventName: '',
      date: DateTimeHelper.getEmptyDateTime(),
      image: '',
      checkedInTotal: '0',
      guestTotal: '0',
      guestList: [],
      createdAt: DateTimeHelper.getEmptyDateTime(),
      updatedAt: DateTimeHelper.getEmptyDateTime(),
    );
  }

  EventModel toRemoteModel() => EventModel(
        eventId: eventId,
        eventName: eventName,
        date: date,
        image: image,
        checkedInTotal: checkedInTotal,
        guestTotal: guestTotal,
        guestList: guestList,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  factory EventEntity.fromJson(Map<String, dynamic> json) =>
      _$EventEntityFromJson(json);
}
