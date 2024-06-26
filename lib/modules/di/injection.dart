import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/presentation/cubit/user_cubit.dart';
import '../../features/event_detail/presentation/cubit/event_detail_cubit.dart';
import '../../features/events/data/data_source/event_data_source.dart';
import '../../features/events/data/repositories/event_repo_impl.dart';
import '../../features/events/domain/repositories/event_repo.dart';
import '../../features/events/domain/usecases/get_checked_in_guests_total_usecase.dart';
import '../../features/events/domain/usecases/get_event_usecase.dart';
import '../../features/events/domain/usecases/get_events_usecase.dart';
import '../../features/events/domain/usecases/get_guests_total_usecase.dart';
import '../../features/events/domain/usecases/get_tickets_usecase.dart';
import '../../features/events/presentation/cubit/cubit/events_cubit.dart';
import '../../features/ticket/data/data_source/ticket_data_source.dart';
import '../../features/ticket/data/repositories/ticket_repo_impl.dart';
import '../../features/ticket/domain/repositories/ticket_repo.dart';
import '../../features/ticket/domain/usecases/check_in_ticket_usecase.dart';
import '../../features/ticket/domain/usecases/check_out_ticket_usecase.dart';
import '../../features/ticket/presentation/cubit/ticket_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // * CUBITS
  sl.registerFactory(() => UserCubit());

  sl.registerFactory(
    () => EventsCubit(
      getEventsUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => EventDetailCubit(
      getEventUseCase: sl(),
      getTicketsUseCase: sl(),
      getGuestsTotalUseCase: sl(),
      getCheckedInGuestsTotalUseCase: sl(),
      checkInTicketUseCase: sl(),
      checkOutTicketUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => TicketCubit(
      checkInTicketUseCase: sl(),
    ),
  );

  // * USECASES
  // events
  sl.registerFactory(() => GetEventUseCase(eventRepo: sl()));
  sl.registerFactory(() => GetEventsUseCase(eventRepo: sl()));

  // event detail
  sl.registerFactory(() => GetTicketsUseCase(eventRepo: sl()));
  sl.registerFactory(() => GetGuestsTotalUseCase(eventRepo: sl()));
  sl.registerFactory(() => GetCheckedInGuestsTotalUseCase(eventRepo: sl()));

  // ticket
  sl.registerFactory(() => CheckInTicketUseCase(ticketRepo: sl()));
  sl.registerFactory(() => CheckOutTicketUseCase(ticketRepo: sl()));

  // * REPOSITORIES
  sl.registerFactory<EventRepo>(() => EventRepoImpl(
        eventDataSource: sl(),
        ticketDataSource: sl(),
      ));

  sl.registerFactory<TicketRepo>(() => TicketRepoImpl(
        ticketDataSource: sl(),
      ));

  // * DATA SOURCES
  sl.registerFactory<EventDataSource>(
    () => EventDataSourceImpl(
      firebaseFirestore: sl(),
    ),
  );
  sl.registerFactory<TicketDataSource>(
    () => TicketDataSourceImpl(
      firebaseFirestore: sl(),
    ),
  );

  // user isar
  // sl.registerFactory<UserLocalIsarDataSource>(
  //   () => UserLocalIsarDataSourceImpl(
  //     sharedPrefLocalDataSource: sl(),
  //   ),
  // );

  // shared pref
  // sl.registerFactory<SharedPrefLocalDataSource>(
  //   () => SharedPrefLocalDataSourceImpl(
  //     prefs: sl(),
  //   ),
  // );

  // * SHARED PREF
  sl.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });

  // * FIREBASE
  sl.registerFactory(() => FirebaseFirestore.instance);
}
