import 'package:fpdart/fpdart.dart';

import '../../../../core/domain/failures/failures.dart';
import '../entities/event_entity.dart';

abstract class EventRepo {
  Future<Either<Failure, List<EventEntity>>> getEvents();
  Future<Either<Failure, EventEntity>> getEvent({required String eventId});
}
