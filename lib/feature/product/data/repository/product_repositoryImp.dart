
import 'package:appro_chat/feature/status/data/model/product_model.dart';
import 'package:dio/dio.dart';


import '../../../../core/error/custome_error.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/repository/product_repository.dart';
import '../data_source/remote/product_api_provider.dart';

class ProductRepositoryimp extends ProductRepository {
  ProductApiProvider productApiProvider;
  ProductRepositoryimp(this.productApiProvider);
  @override
  Future<DataState<List<ProductModel>>> getProducts() async {
    Response response = await productApiProvider.getProduct();

    if (response.statusCode == 200) {
      final List<ProductModel> productItems = [];
      (response.data as List<dynamic>).forEach((element) {
        productItems.add(ProductModel.fromJson(element));
      });
      print(productItems.first.price);
      return DataSuccess(productItems);
    } else {
      return DataError(
          errorConvertor(response.statusCode, response.data['message']));
    }
  }
  
  @override
  Future<DataState<String>> getPayment(String productId) async{
      Response response = await productApiProvider.getPayment(productId);
      if (response.statusCode == 200) {
       return DataSuccess(response.data['url']); 
      }else {
        return DataError(
          errorConvertor(response.statusCode, response.data['message']));
      }
  }

  Future<DataState<String>> myketPayment(String productId, String productUuid) async {
     String res = await productApiProvider.myketPayment(productId, productUuid);

    if (res == 'ok') {
     
      return const DataSuccess('ok');
      
  }else {
    return DataError(errorConvertor(null, 'مشکلی در پرداخت رخ داده است'));
  }
}
}
