import 'package:appro_chat/core/localstorage/local_data.dart';
import 'package:appro_chat/feature/home/data/data_source/remote/home_api_provider.dart';
import 'package:appro_chat/feature/home/data/repository/home_repositoryImpl.dart';
import 'package:appro_chat/feature/home/domain/repository/home_repository.dart';
import 'package:appro_chat/feature/home/domain/usecase/store_chat_usecase.dart';
import 'package:appro_chat/feature/home/presentation/bloc/chat_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
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

  ///api
  locator.registerSingleton<HomeApiProvider>(HomeApiProvider());

  //repo
  locator.registerSingleton<HomeRepository>(
      HomeRepositoryimpl(homeApiProvider: locator()));

  //usecase
  locator.registerSingleton<StoreChatUsecase>(StoreChatUsecase(locator()));

  //bloc
  locator.registerSingleton<ChatBloc>(ChatBloc(locator()));
  // locator.registerFactory<ProductBloc>(()=>ProductBloc(locator() , locator() , locator()));
}
