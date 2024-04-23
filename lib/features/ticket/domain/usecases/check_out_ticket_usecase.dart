import 'package:fpdart/fpdart.dart';

import '../../../../../core/domain/failures/failures.dart';
import '../../../../core/domain/success/success.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../repositories/ticket_repo.dart';

class CheckOutTicketUseCase implements UseCase<Success, String> {
  final TicketRepo ticketRepo;

  CheckOutTicketUseCase({required this.ticketRepo});

  @override
  Future<Either<Failure, Success>> call(String ticketId) async {
    return await ticketRepo.checkOutTicket(
      ticketId: ticketId,
    );
  }
}
