import 'package:flutter_mini/bloc/auth/auth_bloc.dart';
import 'package:flutter_mini/core/network/api_client.dart';
import 'package:flutter_mini/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_mini/data/datasources/product_remote_datesorces.dart';
import 'package:flutter_mini/data/repositoryImpl/auth_repository_impl.dart';
import 'package:flutter_mini/domain/repositories/auth_repository.dart';
import 'package:flutter_mini/domain/usecases/logout_usecase.dart';
import 'package:flutter_mini/domain/usecases/register_usecase.dart';
import 'package:get_it/get_it.dart';
import '../domain/usecases/login_usecase.dart';

final sl = GetIt.instance;

void init() {
  // Dio
  sl.registerLazySingleton(() => ApiClient());

  // Data Source
  sl.registerLazySingleton(() => AuthRemoteDataSource(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => ProductRemoteDatesorces(sl<ApiClient>()));
}
