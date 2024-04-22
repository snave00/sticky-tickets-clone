import 'package:fpdart/fpdart.dart';

import '../../../../../core/domain/failures/failures.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../entities/ticket_entity.dart';
import '../params/scan_ticket_params.dart';
import '../repositories/ticket_repo.dart';

class CheckInTicketUseCase implements UseCase<TicketEntity, ScanTicketParams> {
  final TicketRepo ticketRepo;

  CheckInTicketUseCase({required this.ticketRepo});

  @override
  Future<Either<Failure, TicketEntity>> call(
      ScanTicketParams scanTicketParams) async {
    return await ticketRepo.checkInTicket(
      ticketId: scanTicketParams.ticketId,
      eventId: scanTicketParams.eventId,
    );
  }
}
