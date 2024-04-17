import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/remote_models/event_model.dart';

part 'event_entity.freezed.dart';
part 'event_entity.g.dart';

@freezed
class EventEntity with _$EventEntity {
  EventEntity._();

  factory EventEntity({
    required final String eventId,
    required final String eventName,
    required final String date,
    required final String image,
    required final String checkedInTotal,
    required final String guestTotal,
    required final List<String> guestList,
  }) = _EventEntity;

  factory EventEntity.empty() {
    return EventEntity(
      eventId: '',
      eventName: '',
      date: '',
      image: '',
      checkedInTotal: '0',
      guestTotal: '0',
      guestList: [],
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
      );

  factory EventEntity.fromJson(Map<String, dynamic> json) =>
      _$EventEntityFromJson(json);
}
