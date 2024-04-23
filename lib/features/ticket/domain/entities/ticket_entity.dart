import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../utils/helpers/shared/date_time_helper.dart';
import '../../data/models/remote_models/ticket_model.dart';
import 'guest_entity.dart';

part 'ticket_entity.freezed.dart';
part 'ticket_entity.g.dart';

@freezed
class TicketEntity with _$TicketEntity {
  TicketEntity._();

  factory TicketEntity({
    required final String ticketId,
    required final String ticketName,
    required final String ticketType,
    required final String eventId,
    required final bool isScanned,
    required final GuestEntity guest,
    required final DateTime createdAt,
    required final DateTime scannedAt,
  }) = _TicketEntity;

  factory TicketEntity.empty() {
    return TicketEntity(
      ticketId: '',
      ticketName: '',
      ticketType: '',
      eventId: '',
      isScanned: false,
      guest: GuestEntity.empty(),
      createdAt: DateTimeHelper.getEmptyDateTime(),
      scannedAt: DateTimeHelper.getEmptyDateTime(),
    );
  }

  TicketModel toRemoteModel() => TicketModel(
        ticketId: ticketId,
        ticketName: ticketName,
        ticketType: ticketType,
        eventId: eventId,
        isScanned: isScanned,
        guest: guest.toRemoteModel(),
        createdAt: createdAt,
        scannedAt: scannedAt,
      );

  factory TicketEntity.fromJson(Map<String, dynamic> json) =>
      _$TicketEntityFromJson(json);
}
