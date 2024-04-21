import 'package:fpdart/fpdart.dart';

import '../../../../core/domain/failures/failures.dart';
import '../../../../utils/enums/event_type_enum.dart';
import '../entities/event_entity.dart';
import '../entities/ticket_entity.dart';

abstract class EventRepo {
  Future<Either<Failure, List<EventEntity>>> getEvents({
    required EventType eventType,
  });
  Future<Either<Failure, EventEntity>> getEvent({required String eventId});

  Future<Either<Failure, List<TicketEntity>>> getTickets({
    required String eventId,
  });

  Future<Either<Failure, int>> getGuestTotal({required String eventId});

  Future<Either<Failure, int>> getCheckedInGuestsTotal({
    required String eventId,
  });
}
