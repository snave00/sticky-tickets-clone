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
import '../../features/home/cubit/home_cubit.dart';
import '../../features/product/data/data_source/product_mock_data_source.dart';
import '../../features/product/data/repositories/product_repo_impl.dart';
import '../../features/product/domain/repositories/product_repo.dart';
import '../../features/product/domain/usecases/get_product_categories_usecase.dart';
import '../../features/product/domain/usecases/get_product_usecase.dart';
import '../../features/product/domain/usecases/get_products_usecase.dart';
import '../../features/promos/data/data_source/promo_mock_data_source.dart';
import '../../features/promos/data/repositories/promo_repo_impl.dart';
import '../../features/promos/domain/repositories/promo_repo.dart';
import '../../features/promos/domain/usecases/get_promos_usecase.dart';

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
    ),
  );
  sl.registerFactory(
    () => HomeCubit(
      getProductCategoriesUseCase: sl(),
      getProductsUseCase: sl(),
      getPromosUseCase: sl(),
    ),
  );

  // * USECASES
  // events
  sl.registerFactory(() => GetEventUseCase(eventRepo: sl()));
  sl.registerFactory(() => GetEventsUseCase(eventRepo: sl()));
  sl.registerFactory(() => GetTicketsUseCase(eventRepo: sl()));
  sl.registerFactory(() => GetGuestsTotalUseCase(eventRepo: sl()));
  sl.registerFactory(() => GetCheckedInGuestsTotalUseCase(eventRepo: sl()));

  // product
  sl.registerFactory(() => GetProductUseCase(productRepo: sl()));
  sl.registerFactory(() => GetProductsUseCase(productRepo: sl()));
  sl.registerFactory(() => GetProductCategoriesUseCase(productRepo: sl()));

  // promo
  sl.registerFactory(() => GetPromosUseCase(promoRepo: sl()));

  // * REPOSITORIES
  sl.registerFactory<EventRepo>(() => EventRepoImpl(
        eventDataSource: sl(),
      ));

  sl.registerFactory<PromoRepo>(() => PromoRepoImpl(
        promoMockDataSource: sl(),
      ));
  sl.registerFactory<ProductRepo>(() => ProductRepoImpl(
        productMockDataSource: sl(),
      ));

  // * DATA SOURCES
  sl.registerFactory<EventDataSource>(
    () => EventDataSourceImpl(
      firebaseFirestore: sl(),
    ),
  );

  sl.registerFactory<PromoMockDataSource>(
    () => PromoMockDataSourceImpl(),
  );

  // product mock data
  sl.registerFactory<ProductMockDataSource>(
    () => ProductMockDataSourceImpl(),
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
