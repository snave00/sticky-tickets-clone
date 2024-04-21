import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/data/exceptions/cache_exception.dart';
import '../../../../core/data/exceptions/network_exception.dart';
import '../../../../core/domain/failures/failures.dart';
import '../../../../utils/constants/error_const.dart';
import '../../../../utils/enums/event_type_enum.dart';
import '../../../../utils/logs/custom_log.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/entities/ticket_entity.dart';
import '../../domain/repositories/event_repo.dart';
import '../data_source/event_data_source.dart';

class EventRepoImpl implements EventRepo {
  static String runtimeTypeName = (EventRepoImpl).toString();

  final EventDataSource eventDataSource;

  EventRepoImpl({
    required this.eventDataSource,
  });

  @override
  Future<Either<Failure, List<EventEntity>>> getEvents({
    required EventType eventType,
  }) async {
    try {
      final events = await eventDataSource.getEvents(eventType: eventType);

      final eventsToEntity = events.map((event) => event.toEntity()).toList();
      final eventsToJson =
          eventsToEntity.map((event) => event.toJson()).toList();

      Log.logRepo(
        repoName: runtimeTypeName,
        functionName: 'getEvents success: ',
        log: eventsToJson,
      );
      return right(eventsToEntity);
    } on PlatformException catch (e) {
      return left(PlatformFailure(
          '${ErrorConst.platFormErrorMessage}. getEvents\n${e.toString()}'));
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.toString()));
    } on FirebaseException catch (e) {
      return left(FirebaseFailure(e.message.toString()));
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
      final event = await eventDataSource.getEvent(eventId: eventId);
      final eventEntity = event?.toEntity() ?? EventEntity.empty();

      final eventToJson = event?.toJson();

      Log.logRepo(
        repoName: runtimeTypeName,
        functionName: 'getEvent success: ',
        log: eventToJson,
      );

      return right(eventEntity);
    } on PlatformException catch (e) {
      return left(PlatformFailure(
          '${ErrorConst.platFormErrorMessage}. getEvent\n${e.toString()}'));
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.toString()));
    } on FirebaseException catch (e) {
      return left(FirebaseFailure(e.message.toString()));
    } catch (e) {
      return left(
        GeneralFailure(
            '${ErrorConst.generalErrorMessage} getEvent()\n${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, List<TicketEntity>>> getTickets({
    required String eventId,
  }) async {
    try {
      final tickets = await eventDataSource.getTickets(eventId: eventId);

      final ticketsToEntity =
          tickets.map((ticket) => ticket.toEntity()).toList();
      final ticketsToJson =
          ticketsToEntity.map((ticket) => ticket.toJson()).toList();

      Log.logRepo(
        repoName: runtimeTypeName,
        functionName: 'getTickets success: ',
        log: ticketsToJson,
      );
      return right(ticketsToEntity);
    } on PlatformException catch (e) {
      return left(PlatformFailure(
          '${ErrorConst.platFormErrorMessage}. getTickets\n${e.toString()}'));
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.toString()));
    } on FirebaseException catch (e) {
      return left(FirebaseFailure(e.message.toString()));
    } on CacheException catch (e) {
      return left(CacheFailure(e.toString()));
    } catch (e) {
      return left(GeneralFailure(
          '${ErrorConst.generalErrorMessage}. getTickets\n${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, int>> getGuestTotal({required String eventId}) async {
    try {
      final guestsTotal = await eventDataSource.getGuestTotal(eventId: eventId);

      Log.logRepo(
        repoName: runtimeTypeName,
        functionName: 'getGuestTotal success: $guestsTotal',
      );
      return right(guestsTotal);
    } on PlatformException catch (e) {
      return left(PlatformFailure(
          '${ErrorConst.platFormErrorMessage}. getGuestTotal\n${e.toString()}'));
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.toString()));
    } on FirebaseException catch (e) {
      return left(FirebaseFailure(e.message.toString()));
    } on CacheException catch (e) {
      return left(CacheFailure(e.toString()));
    } catch (e) {
      return left(GeneralFailure(
          '${ErrorConst.generalErrorMessage}. getGuestTotal\n${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, int>> getCheckedInGuestsTotal({
    required String eventId,
  }) async {
    try {
      final checkedInGuestsTotal =
          await eventDataSource.getCheckedInGuestsTotal(
        eventId: eventId,
      );

      Log.logRepo(
        repoName: runtimeTypeName,
        functionName: 'getCheckedInGuestsTotal success: $checkedInGuestsTotal',
      );
      return right(checkedInGuestsTotal);
    } on PlatformException catch (e) {
      return left(PlatformFailure(
          '${ErrorConst.platFormErrorMessage}. getCheckedInGuestsTotal\n${e.toString()}'));
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.toString()));
    } on FirebaseException catch (e) {
      return left(FirebaseFailure(e.message.toString()));
    } on CacheException catch (e) {
      return left(CacheFailure(e.toString()));
    } catch (e) {
      return left(GeneralFailure(
          '${ErrorConst.generalErrorMessage}. getCheckedInGuestsTotal\n${e.toString()}'));
    }
  }
}
