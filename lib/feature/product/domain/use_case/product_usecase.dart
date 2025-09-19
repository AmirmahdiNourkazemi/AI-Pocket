
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../../../status/data/model/product_model.dart';
import '../repository/product_repository.dart';

class ProductUseCase implements UseCase<DataState<List<ProductModel>>, void> {
  final ProductRepository productRepository;

  ProductUseCase(this.productRepository);
  @override
  Future<DataState<List<ProductModel>>> call(void params) {
    return productRepository.getProducts();
  }
}
