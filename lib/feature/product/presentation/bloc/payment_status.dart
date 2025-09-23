abstract class PaymentStatus {}

class ProductPaymentInit extends PaymentStatus {}

class ProductPaymentSuccess extends PaymentStatus {
  final String url;
  ProductPaymentSuccess(this.url);
}

class ProductPaymentError extends PaymentStatus {
  final String message;
  ProductPaymentError(this.message);
}

class ProductPaymentLoading extends PaymentStatus {
  final String id;
  ProductPaymentLoading(this.id);
}
