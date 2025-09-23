import 'package:appro_chat/core/const/app_string.dart';
import 'package:dio/dio.dart';
import 'package:flutter_poolakey/flutter_poolakey.dart';
import 'package:flutter_poolakey/purchase_info.dart';
import '../../../../../core/localstorage/local_data.dart';
import '../../../../../core/locator/locator.dart';
import '../../../../../core/network/api_provider_imp.dart';

class ProductApiProvider {
  Future<Response> getProduct() async {
    final res = await locator<ApiProviderImp>().get(
        'https://api.approagency.ir/api/package-names/${AppString.packageName}/products',
        headerParameter: {
          'Authorization': 'Bearer ${LocalData.firstTokenNotifier.value}',
        });
    return res;
  }

  Future<Response> getPayment(String productId) async {
    final res = await locator<ApiProviderImp>()
        .post('$AppString.baseUrl/zarinpal/gateway', headerParametr: {
      'Authorization': 'Bearer ${LocalData.firstTokenNotifier.value}',
    }, bodyParameter: {
      'product_id': productId,
      'description': 'توضیحات پرداخت',
    });
    return res;
  }

    Future<String> myketPayment(String productId, String productUuid) async {
      try {
    await FlutterPoolakey.connect(AppString.bazzarRSA, onDisconnected: () {
      print('object');
      return;
    });
    PurchaseInfo purchaseInfo = await FlutterPoolakey.subscribe(productUuid);
    final subUserResponse = await locator<ApiProviderImp>().put(
        'https://api.approagency.ir/api/package-names/${AppString.packageName}/products/$productId/subscribe',
        bodyParameters: {
          'purchase_token': purchaseInfo.purchaseToken,
          'gateway': 'cafe'
        },
        headerParameters: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${LocalData.firstTokenNotifier.value}'
        },
        queryParameter: {
          'name': AppString.packageName,
          'product_id': productId
        });

    if (subUserResponse.statusCode == 200) {
      return 'ok';
    } else {
      return 'error';
    }
      }catch (e) {
        print(e);
        return 'error';
      }
    
  }
}
