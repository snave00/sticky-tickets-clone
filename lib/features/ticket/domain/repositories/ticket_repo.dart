import 'package:fpdart/fpdart.dart';

import '../../../../core/domain/failures/failures.dart';
import '../entities/ticket_entity.dart';

abstract class TicketRepo {
  Future<Either<Failure, TicketEntity>> scanTicket({
    required String ticketId,
    required String eventId,
  });
}
