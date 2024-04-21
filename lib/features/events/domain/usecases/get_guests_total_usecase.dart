import 'package:fpdart/fpdart.dart';

import '../../../../../core/domain/failures/failures.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../repositories/event_repo.dart';

class GetGuestsTotalUseCase implements UseCase<int, String> {
  final EventRepo eventRepo;

  GetGuestsTotalUseCase({required this.eventRepo});

  @override
  Future<Either<Failure, int>> call(String eventId) async {
    return await eventRepo.getGuestTotal(eventId: eventId);
  }
}
