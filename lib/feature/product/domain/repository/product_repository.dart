import '../../../../core/resources/data_state.dart';
import '../../../status/data/model/product_model.dart';

abstract class ProductRepository {
  Future<DataState<List<ProductModel>>> getProducts();
  Future<DataState<String>> getPayment(String productId);
  Future<DataState<String>> myketPayment(String productId, String productUuid);
}