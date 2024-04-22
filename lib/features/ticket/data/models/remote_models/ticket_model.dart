import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../utils/helpers/shared/date_time_helper.dart';
import '../../../../../utils/helpers/shared/time_stamp_converter.dart';
import '../../../domain/entities/guest_entity.dart';
import '../../../domain/entities/ticket_entity.dart';
import 'guest_model.dart';

part 'ticket_model.freezed.dart';
part 'ticket_model.g.dart';

@freezed
class TicketModel with _$TicketModel {
  TicketModel._();

  factory TicketModel({
    final String? ticketId,
    final String? ticketName,
    final String? ticketType,
    final String? eventId,
    final bool? isScanned,
    final GuestModel? guest,
    @TimestampOrNullConverter() final DateTime? createdAt,
    @TimestampOrNullConverter() final DateTime? scannedAt,
  }) = _TicketModel;

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);

  factory TicketModel.empty() {
    return TicketModel(
      ticketId: '',
      ticketName: '',
      ticketType: '',
      eventId: '',
      isScanned: false,
      guest: GuestModel.empty(),
      createdAt: DateTimeHelper.getEmptyDateTime(),
      scannedAt: DateTimeHelper.getEmptyDateTime(),
    );
  }

  TicketEntity toEntity() => TicketEntity(
        ticketId: ticketId ?? '',
        ticketName: ticketName ?? '',
        ticketType: ticketType ?? '',
        eventId: eventId ?? '',
        isScanned: isScanned ?? false,
        guest: guest?.toEntity() ?? GuestEntity.empty(),
        createdAt: createdAt ?? DateTimeHelper.getEmptyDateTime(),
        scannedAt: scannedAt ?? DateTimeHelper.getEmptyDateTime(),
      );
}
