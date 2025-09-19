
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/product_repository.dart';

class PaymentUsecase implements UseCase<DataState<String>, String> {
  final ProductRepository productRepository;

  PaymentUsecase(this.productRepository);
  @override
  Future<DataState<String>> call(String params) {
    return productRepository.getPayment(params);
  }
}
