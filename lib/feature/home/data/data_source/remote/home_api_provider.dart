import 'package:appro_chat/core/locator/locator.dart';
import 'package:appro_chat/core/network/api_provider_imp.dart';
import 'package:dio/dio.dart';

class HomeApiProvider {
  Future<Response> storeChat(String system, String user) async {
    final response = await locator<ApiProviderImp>()
        .post('https://chat.approagency.ir/api/chat', bodyParameter: {
      "messages": [
        {"role": "system", "content": system},
        {"role": "user", "content": user}
      ]
    });
    return response;
  }
}
