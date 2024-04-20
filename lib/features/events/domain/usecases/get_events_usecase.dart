import 'package:fpdart/fpdart.dart';

import '../../../../../core/domain/failures/failures.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../../../../utils/enums/event_type_enum.dart';
import '../entities/event_entity.dart';
import '../repositories/event_repo.dart';

class GetEventsUseCase implements UseCase<List<EventEntity>, EventType> {
  final EventRepo eventRepo;

  GetEventsUseCase({required this.eventRepo});

  @override
  Future<Either<Failure, List<EventEntity>>> call(EventType eventType) async {
    return await eventRepo.getEvents(eventType: eventType);
  }
}
