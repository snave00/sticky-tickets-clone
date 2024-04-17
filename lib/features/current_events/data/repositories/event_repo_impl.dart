import 'package:fpdart/fpdart.dart';

import '../../../../core/data/exceptions/cache_exception.dart';
import '../../../../core/domain/failures/failures.dart';
import '../../../../utils/constants/error_const.dart';
import '../../../../utils/logs/custom_log.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/repositories/event_repo.dart';
import '../data_source/event_data_source.dart';

class EventRepoImpl implements EventRepo {
  static String runtimeTypeName = (EventRepoImpl).toString();

  final EventDataSource eventDataSource;

  EventRepoImpl({
    required this.eventDataSource,
  });

  @override
  Future<Either<Failure, List<EventEntity>>> getEvents() async {
    try {
      final events = await eventDataSource.getEvents();

      final eventsToEntity = events.map((event) => event.toEntity()).toList();
      final eventsToJson =
          eventsToEntity.map((event) => event.toJson()).toList();

      Log.logRepo(
        repoName: runtimeTypeName,
        functionName: 'getEvents success: ',
        log: eventsToJson,
      );
      return right(eventsToEntity);
    } on CacheException catch (e) {
      return left(CacheFailure(e.toString()));
    } catch (e) {
      return left(GeneralFailure(
          '${ErrorConst.generalErrorMessage}. getEvents\n${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, EventEntity>> getEvent({
    required String eventId,
  }) async {
    try {
      final event = await eventDataSource.getEvent(
        eventId: eventId,
      );

      final eventToEntity = event.toEntity();
      final eventToJson = eventToEntity.toJson();

      Log.logRepo(
        repoName: runtimeTypeName,
        functionName: 'getEvent success: ',
        log: eventToJson,
      );
      return right(eventToEntity);
    } on CacheException catch (e) {
      return left(CacheFailure(e.toString()));
    } catch (e) {
      return left(GeneralFailure(
          '${ErrorConst.generalErrorMessage}. getEvent\n${e.toString()}'));
    }
  }
}
