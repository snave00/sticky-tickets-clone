import 'package:fpdart/fpdart.dart';

import '../../../../core/domain/failures/failures.dart';
import '../../../../core/domain/success/success.dart';
import '../entities/ticket_entity.dart';

abstract class TicketRepo {
  Future<Either<Failure, TicketEntity>> checkInTicket({
    required String ticketId,
    required String eventId,
  });

  Future<Either<Failure, Success>> checkOutTicket({
    required String ticketId,
  });
}
