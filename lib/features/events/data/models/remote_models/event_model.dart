import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../utils/helpers/shared/date_time_helper.dart';
import '../../../../../utils/helpers/shared/time_stamp_converter.dart';
import '../../../domain/entities/event_entity.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
class EventModel with _$EventModel {
  EventModel._();

  factory EventModel({
    final String? eventId,
    final String? eventName,
    final String? description,
    final String? eventType,
    final String? venue,
    // <-- this is nullable, so the converter needs to handle null
    @TimestampOrNullConverter() final DateTime? date,
    final String? image,
    final String? checkedInTotal,
    final String? guestTotal,
    final String? colorHex,
    final List<String>? guestList,
    @TimestampOrNullConverter() final DateTime? createdAt,
    @TimestampOrNullConverter() final DateTime? updatedAt,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  factory EventModel.empty() {
    return EventModel(
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

  EventEntity toEntity() => EventEntity(
        eventId: eventId ?? '',
        eventName: eventName ?? '',
        description: description ?? '',
        eventType: eventType ?? '',
        venue: venue ?? '',
        date: date ?? DateTimeHelper.getEmptyDateTime(),
        image: image ?? '',
        checkedInTotal: checkedInTotal ?? '',
        guestTotal: guestTotal ?? '',
        colorHex: colorHex ?? '',
        guestList: guestList ?? [],
        createdAt: createdAt ?? DateTimeHelper.getEmptyDateTime(),
        updatedAt: updatedAt ?? DateTimeHelper.getEmptyDateTime(),
      );
}
