import 'package:fpdart/fpdart.dart';

import '../../../../../core/domain/failures/failures.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../entities/event_entity.dart';
import '../repositories/event_repo.dart';

class GetEventsUseCase implements UseCase<List<EventEntity>, NoParams> {
  final EventRepo eventRepo;

  GetEventsUseCase({required this.eventRepo});

  @override
  Future<Either<Failure, List<EventEntity>>> call(NoParams noParams) async {
    return await eventRepo.getEvents();
  }
}
