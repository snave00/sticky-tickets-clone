import 'package:fpdart/fpdart.dart';

import '../../../../../core/domain/failures/failures.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../entities/ticket_entity.dart';
import '../repositories/event_repo.dart';

class GetTicketsUseCase implements UseCase<List<TicketEntity>, String> {
  final EventRepo eventRepo;

  GetTicketsUseCase({required this.eventRepo});

  @override
  Future<Either<Failure, List<TicketEntity>>> call(String eventId) async {
    return await eventRepo.getTickets(eventId: eventId);
  }
}
