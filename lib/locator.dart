import 'package:flutter_mini/bloc/auth/auth_bloc.dart';
import 'package:flutter_mini/bloc/cart/bloc/cart_bloc.dart';
import 'package:flutter_mini/bloc/product/bloc/product_bloc.dart';
import 'package:flutter_mini/core/network/api_client.dart';
import 'package:flutter_mini/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_mini/data/datasources/cart_remoted_datasource.dart';
import 'package:flutter_mini/data/datasources/product_remote_datesorces.dart';
import 'package:flutter_mini/data/repositoryImpl/auth_repository_impl.dart';
import 'package:flutter_mini/data/repositoryImpl/cart_repository_impl.dart';
import 'package:flutter_mini/data/repositoryImpl/product_repository_impl.dart';
import 'package:flutter_mini/domain/repositories/auth_repository.dart';
import 'package:flutter_mini/domain/repositories/cart_repository.dart';
import 'package:flutter_mini/domain/repositories/product_repository.dart';
import 'package:flutter_mini/domain/usecases/auth/logout_usecase.dart';
import 'package:flutter_mini/domain/usecases/cart/cart_usecase.dart';
import 'package:flutter_mini/domain/usecases/product/product_usecase.dart';
import 'package:flutter_mini/domain/usecases/auth/register_usecase.dart';
import 'package:get_it/get_it.dart';
import 'domain/usecases/auth/login_usecase.dart';

final sl = GetIt.instance;

void init() {
  // Network
  sl.registerLazySingleton(() => ApiClient());

  // Data Sources
  sl.registerLazySingleton(() => AuthRemoteDataSource(sl()));
  sl.registerLazySingleton(() => ProductRemoteDatesorces(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => ProductUsecase(sl()));

  // BLoCs
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );

  sl.registerFactory(() => ProductBloc(sl())); // ⬅️ product bloc

  //

  sl.registerLazySingleton(() => CartRemoteDataSource(sl()));

  // Repository
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));

  // Use Cases
  sl.registerLazySingleton(() => CartUsecase(sl()));

  // Bloc
  sl.registerFactory(() => CartBloc(cartUseCase: sl()));
}
