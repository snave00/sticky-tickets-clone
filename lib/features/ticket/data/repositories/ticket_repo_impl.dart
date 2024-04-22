import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/data/exceptions/cache_exception.dart';
import '../../../../core/data/exceptions/network_exception.dart';
import '../../../../core/domain/failures/failures.dart';
import '../../../../utils/constants/error_const.dart';
import '../../../../utils/logs/custom_log.dart';
import '../../../ticket/data/data_source/ticket_data_source.dart';
import '../../domain/entities/ticket_entity.dart';
import '../../domain/repositories/ticket_repo.dart';

class TicketRepoImpl implements TicketRepo {
  static String runtimeTypeName = (TicketRepoImpl).toString();

  final TicketDataSource ticketDataSource;

  TicketRepoImpl({
    required this.ticketDataSource,
  });

  @override
  Future<Either<Failure, TicketEntity>> scanTicket({
    required String ticketId,
    required String eventId,
  }) async {
    try {
      final ticket = await ticketDataSource.getTicket(ticketId: ticketId);
      final ticketEntity = ticket?.toEntity() ?? TicketEntity.empty();
      final ticketToJson = ticket?.toJson();

      // ticket is not for the event
      if (ticketEntity.eventId != eventId) {
        return left(GeneralFailure(ErrorConst.ticketNotValid));
      }

      // ticket has been already scanned
      if (ticketEntity.isScanned) {
        return left(GeneralFailure(ErrorConst.ticketAlreadyScanned));
      }

      // scan ticket
      await ticketDataSource.scanTicket(ticketId: ticketId);

      Log.logRepo(
        repoName: runtimeTypeName,
        functionName: 'scanTicket success: ',
        log: ticketToJson,
      );
      return right(ticketEntity);
    } on PlatformException catch (e) {
      return left(PlatformFailure(
          '${ErrorConst.platFormErrorMessage}. scanTicket\n${e.toString()}'));
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.toString()));
    } on FirebaseException catch (e) {
      return left(FirebaseFailure(e.message.toString()));
    } on CacheException catch (e) {
      return left(CacheFailure(e.toString()));
    } catch (e) {
      return left(GeneralFailure(
          '${ErrorConst.generalErrorMessage}. scanTicket\n${e.toString()}'));
    }
  }
}
