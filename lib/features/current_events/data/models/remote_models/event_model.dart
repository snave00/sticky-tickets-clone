import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/event_entity.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
class EventModel with _$EventModel {
  EventModel._();

  factory EventModel({
    final String? eventId,
    final String? eventName,
    final String? date,
    final String? image,
    final String? checkedInTotal,
    final String? guestTotal,
    final List<String>? guestList,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  factory EventModel.empty() {
    return EventModel(
      eventId: '',
      eventName: '',
      date: '',
      image: '',
      checkedInTotal: '0',
      guestTotal: '0',
      guestList: [],
    );
  }

  EventEntity toEntity() => EventEntity(
        eventId: eventId ?? '',
        eventName: eventName ?? '',
        date: date ?? '',
        image: image ?? '',
        checkedInTotal: checkedInTotal ?? '',
        guestTotal: guestTotal ?? '',
        guestList: guestList ?? [],
      );
}
