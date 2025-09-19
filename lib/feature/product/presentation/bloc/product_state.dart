import 'payment_status.dart';
import 'product_status.dart';

class ProductState {
  final ProductStatus status;
  final PaymentStatus paymentStatus;

  ProductState({required this.status ,required this.paymentStatus});
  ProductState copyWith({ProductStatus? status , PaymentStatus? paymentStatus}) {
    return ProductState(status: status ?? this.status , paymentStatus: paymentStatus ?? this.paymentStatus);
  }
}
