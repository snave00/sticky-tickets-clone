import 'package:fpdart/fpdart.dart';

import '../../../../../core/domain/failures/failures.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../entities/event_entity.dart';
import '../repositories/event_repo.dart';

class GetEventUseCase implements UseCase<EventEntity, String> {
  final EventRepo eventRepo;

  GetEventUseCase({required this.eventRepo});

  @override
  Future<Either<Failure, EventEntity>> call(String eventId) async {
    return await eventRepo.getEvent(eventId: eventId);
  }
}
