import 'package:appro_chat/core/localstorage/local_data.dart';
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

  ///repositories
  // locator.registerFactory<ProductBloc>(()=>ProductBloc(locator() , locator() , locator()));
}
