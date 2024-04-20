import 'package:fpdart/fpdart.dart';

import '../../../../core/domain/failures/failures.dart';
import '../../../../utils/enums/event_type_enum.dart';
import '../entities/event_entity.dart';

abstract class EventRepo {
  Future<Either<Failure, List<EventEntity>>> getEvents({
    required EventType eventType,
  });
  Future<Either<Failure, EventEntity>> getEvent({required String eventId});
}
