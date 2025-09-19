import 'package:appro_chat/core/localstorage/local_data.dart';
import 'package:appro_chat/core/session/session_bloc.dart';
import 'package:appro_chat/feature/auth/data/data_source/remote/api_provider.dart';
import 'package:appro_chat/feature/auth/data/repository/auth_repositoryImpl.dart';
import 'package:appro_chat/feature/auth/domain/repository/auth_repository.dart';
import 'package:appro_chat/feature/auth/domain/use_cases/google_use_case.dart';
import 'package:appro_chat/feature/auth/domain/use_cases/login_usecase.dart';
import 'package:appro_chat/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:appro_chat/feature/home/data/data_source/remote/home_api_provider.dart';
import 'package:appro_chat/feature/home/data/repository/home_repositoryImpl.dart';
import 'package:appro_chat/feature/home/domain/repository/home_repository.dart';
import 'package:appro_chat/feature/home/domain/usecase/store_chat_usecase.dart';
import 'package:appro_chat/feature/home/presentation/bloc/chat_bloc.dart';
import 'package:appro_chat/feature/product/data/data_source/remote/product_api_provider.dart';
import 'package:appro_chat/feature/product/data/repository/product_repositoryImp.dart';
import 'package:appro_chat/feature/product/domain/repository/product_repository.dart';
import 'package:appro_chat/feature/product/domain/use_case/myket_payment_usecase.dart';
import 'package:appro_chat/feature/product/domain/use_case/product_usecase.dart';
import 'package:appro_chat/feature/product/presentation/bloc/product_bloc.dart';
import 'package:appro_chat/feature/status/data/data_source/remote/status_api_provider.dart';
import 'package:appro_chat/feature/status/data/repository/status_repositoryImpl.dart';
import 'package:appro_chat/feature/status/domain/repository/status_repository.dart';
import 'package:appro_chat/feature/status/domain/use_case/status_usecase.dart';
import 'package:appro_chat/feature/status/presentation/bloc/status_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_provider_imp.dart';
import '../network/api_providers.dart';
import '../network/dio_wrapper.dart';

GetIt locator = GetIt.instance;

setup() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(sharedPreferences);
  locator.registerSingleton<LocalData>(LocalData());

  /// dio
  locator.registerSingleton<Dio>(ViolationDioWrapper.provide());
  locator.registerSingleton<ApiProviderImp>(ApiProviderImp());
  locator.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  ///api
  locator.registerSingleton<HomeApiProvider>(HomeApiProvider());
  locator.registerSingleton<AuthApiProvider>(AuthApiProvider());
  locator.registerSingleton<StatusApiProvider>(StatusApiProvider());
  locator.registerSingleton<ProductApiProvider>(ProductApiProvider());

  //repo
  locator.registerSingleton<HomeRepository>(
      HomeRepositoryimpl(homeApiProvider: locator()));
  locator.registerSingleton<AuthRepository>(
      AuthRepositoryimpl(locator(), locator()));
  locator.registerSingleton<StatusRepository>(StatusRepositoryimpl(locator()));
  locator.registerSingleton<ProductRepository>(ProductRepositoryimp(locator()));

  //usecase
  locator.registerSingleton<StoreChatUsecase>(StoreChatUsecase(locator()));
  locator.registerSingleton<LoginUsecase>(LoginUsecase(locator()));
  locator.registerSingleton<GoogleUseCase>(GoogleUseCase(locator()));
  locator.registerSingleton<StatusUsecase>(StatusUsecase(locator()));
  locator.registerSingleton<ProductUseCase>(ProductUseCase(locator()));
  locator
      .registerSingleton<MyketPaymentUsecase>(MyketPaymentUsecase(locator()));

  //bloc
  locator.registerFactory<AuthBloc>(
      () => AuthBloc(locator(), locator(), locator()));
  locator.registerSingleton<ChatBloc>(ChatBloc(locator()));
  locator.registerFactory<CheckAuthBloc>(() => CheckAuthBloc());
  locator.registerFactory<StatusBloc>(() => StatusBloc(locator()));
  locator.registerFactory<ProductBloc>(() => ProductBloc(locator(), locator()));
  // locator.registerFactory<ProductBloc>(()=>ProductBloc(locator() , locator() , locator()));
}
