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
    required final String description,
    required final String eventType,
    required final String venue,
    required final DateTime date,
    required final String image,
    required final String checkedInTotal,
    required final String guestTotal,
    required final String colorHex,
    required final List<String> guestList,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _EventEntity;

  factory EventEntity.empty() {
    return EventEntity(
      eventId: '',
      eventName: '',
      description: '',
      eventType: '',
      venue: '',
      date: DateTimeHelper.getEmptyDateTime(),
      image: '',
      checkedInTotal: '0',
      guestTotal: '0',
      colorHex: '',
      guestList: [],
      createdAt: DateTimeHelper.getEmptyDateTime(),
      updatedAt: DateTimeHelper.getEmptyDateTime(),
    );
  }

  EventModel toRemoteModel() => EventModel(
        eventId: eventId,
        eventName: eventName,
        description: description,
        eventType: eventType,
        venue: venue,
        date: date,
        image: image,
        checkedInTotal: checkedInTotal,
        guestTotal: guestTotal,
        colorHex: colorHex,
        guestList: guestList,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  factory EventEntity.fromJson(Map<String, dynamic> json) =>
      _$EventEntityFromJson(json);
}
