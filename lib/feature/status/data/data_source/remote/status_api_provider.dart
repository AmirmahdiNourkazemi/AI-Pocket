import 'package:appro_chat/core/const/app_string.dart';
import 'package:appro_chat/core/locator/locator.dart';
import 'package:appro_chat/core/network/api_provider_imp.dart';
import 'package:dio/dio.dart';
import '../../../../../core/localstorage/local_data.dart';

class StatusApiProvider {
  Future<Response> getStatus() async {
    final res = await locator<ApiProviderImp>()
        .get('https://api.approagency.ir/api/status', queryParameter: {
      'package_name': AppString.packageName,
    }, headerParameter: {
      'Authorization': 'Bearer ${LocalData.firstTokenNotifier.value}',
    });
    return res;
  }

  //   Future<Response> getStatusV1() async {
  //   final res = await locator<ApiProviderImp>().get(
  //     'https://api.approagency.ir/api/paid-status-v1?package_name=${AppString.packageName}',

  //       headerParameter: {
  //         'Authorization': 'Bearer ${LocalData.firstTokenNotifier.value}',
  //       }
  //   );
  //   return res;
  // }
}
